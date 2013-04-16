class InventarioPredioCalculador
  def initialize(inventario_predio)
    @inventario_predio = inventario_predio
    @inventario        = inventario_predio.inventario
    @predio            = inventario_predio.predio
    @recuento          = last_recuento
    @fecha_inicio      = @recuento ? @recuento.fecha.advance(days: 1) : @inventario.gestion.desde
  end

  def calculate_ingr_egr_ganado_predio
    mov = Movimiento.joins(:ganados, :movimientos_tipo)
      .select("movimientos_tipos.id as movimiento_tipo_id, ganados.id as ganado_id, sum(movimiento_ganados.cant) as sumatoria")
      .where("movimientos_tipos.tipo in ('i', 'e') and movimientos.predio_id = ? and gestion_id = ?", 
        @predio.id, @inventario.gestion.id) 
      .group("movimientos_tipos.id, ganados.id")
      .order("movimientos_tipos.tipo asc")

    mov = mov.where("fecha >= ?", @fecha_inicio) if @recuento

    mov.each do |ingr_egr|
      inv_predio_ingr_egr = @inventario_predio.inventario_predio_ingr_egrs
        .find_or_create_by_movimientos_tipo_id(ingr_egr.movimiento_tipo_id)

      ip_ganados = inv_predio_ingr_egr.inventario_predio_ingr_egr_ganados

      ganado = ip_ganados.find_or_initialize_by_ganado_id(ingr_egr.ganado_id)

      # actualizar inventario por predio, ingr/egr, por ganado
      ganado.update_attributes(cant: ingr_egr.sumatoria)

      
      missing = Ganado.where("ganados.id not in (?)", ip_ganados.map(&:ganado_id).push(0))
        .select("ganados.id as ganado_id, 0 as sumatoria")

      missing.each do |ganado|
        ip_ganados.create(ganado_id: ganado.id, cant: 0)
      end
    end

    inv_ingr_egr = @inventario_predio.inventario_predio_ingr_egrs.includes(:inventario_predio_ingr_egr_ganados)

    inv_ingr_egr.each do |ingr_egr|
      # actualizar inventario por predio, ingr/egr
      ingr_egr.update_attributes(
        cant: ingr_egr.inventario_predio_ingr_egr_ganados.sum(&:cant),
        cant_may_a: ingr_egr.inventario_predio_ingr_egr_ganados.select {|g| g.ganado.tipo == "may_a"}.sum(&:cant),
        cant_men_a: ingr_egr.inventario_predio_ingr_egr_ganados.select {|g| g.ganado.tipo == "men_a"}.sum(&:cant)
      )
    end
  end

  def calculate_mov_ganado_predio
    movimientos = Movimiento.joins(:ganados, :movimientos_tipo)
      .select("ganados.id as ganado_id, sum(movimiento_ganados.cant) as cant, sum(movimiento_ganados.cant_sec) as cant_sec, sum(movimiento_ganados.cant)-sum(movimiento_ganados.cant_sec) as perdidos, movimientos.predio_id, movimientos.predio_sec_id")
      .where("movimientos_tipos.tipo in ('m') and gestion_id = ?", 
        @inventario.gestion.id)
      .group("movimientos.predio_id, movimientos.predio_sec_id, ganados.id")

    movimientos = movimientos.where("fecha >= ?", @fecha_inicio) if @recuento

    movimientos.each do |mov|
      inventario_predio = InventarioPredio.get_inventario(mov.predio_id)

      inv_predio_mov = inventario_predio.inventario_predio_movs
        .find_or_create_by_tipo_and_predio_sec_id("egr", mov.predio_sec_id)

      ganado = inv_predio_mov.inventario_predio_mov_ganados
        .find_or_initialize_by_ganado_id(mov.ganado_id)

      ganado.update_attributes(cant: mov.cant, perdidos: mov.perdidos)
      create_missing_mov_ganados(inv_predio_mov.inventario_predio_mov_ganados)

      inventario_predio_sec = InventarioPredio.get_inventario(mov.predio_sec_id)

      inv_predio_mov = inventario_predio_sec.inventario_predio_movs
        .find_or_create_by_tipo_and_predio_sec_id("ingr", mov.predio_id)

      ganado = inv_predio_mov.inventario_predio_mov_ganados
        .find_or_initialize_by_ganado_id(mov.ganado_id)

      ganado.update_attributes(cant: mov.cant_sec, perdidos: mov.perdidos)
      create_missing_mov_ganados(inv_predio_mov.inventario_predio_mov_ganados)


      update_inventario_predio_movs_totals(inventario_predio)
      update_inventario_predio_movs_totals(inventario_predio_sec)
    end
  end

  def calculate_totals(calc_predio_sec=true)
    # calcular inventario por predio por ganado
    saldos_mes_actual = Movimiento.joins(:ganados, :movimientos_tipo)
      .select("ganados.id as ganado_id, "+
        "sum(case when movimientos_tipos.tipo='e' then movimiento_ganados.cant else 0 end) as sum_egresos, "+
        "sum(case when movimientos_tipos.tipo='i' then movimiento_ganados.cant else 0 end) as sum_ingresos")
      .where("movimientos_tipos.tipo in ('i', 'e') and movimientos.predio_id = ? and gestion_id = ?", 
         @predio.id, @inventario.gestion.id)
      .group("ganados.id")

    saldos_mes_actual = saldos_mes_actual.where("fecha >= ?", @fecha_inicio) if @recuento

    missing = Ganado.where("ganados.id not in (?)", saldos_mes_actual.map(&:ganado_id).push(0))
      .select("ganados.id as ganado_id, 0 as sum_egresos, 0 as sum_ingresos")

    movimientos = @inventario_predio.inventario_predio_movs.includes(:inventario_predio_mov_ganados)

    saldos_mes_actual += missing

    saldos_mes_actual.each do |ganado|
      # sumatoria de movimientos de esta gestion 
      # o despues del ultimo recuento de esta gestion si lo hubo
      saldo_parcial = ganado.sum_ingresos.to_i
      saldo_inicial = 0

      if @recuento.nil? # si no hubo un recuento esta gestion, tomar en cuenta la anterior gestion
        if @inventario.gestion.anterior
          inv = @inventario.gestion.anterior.get_inventario.get_inventario_predio(@predio.id)
          inv_ganado = inv.inventario_predio_ganados.find_by_ganado_id(ganado.ganado_id)
          saldo_inicial = inv_ganado.cant if inv_ganado
        end
      else
        # si hubo un recuento esta gestion, se ignoran las gestiones anteriores, 
        # y se suma el recuento a los movimientos realizados despues del mismo
        saldo_inicial = @recuento.movimiento_ganados.find_by_ganado_id(ganado.ganado_id).cant
      end

      saldo_parcial += saldo_inicial

      # sumar los ingresos recividos por movimientos desde otros predios
      saldo_parcial += movimientos.select {|m| m.tipo == "ingr"}.inject(0) do |sum, m|
        g = (m.inventario_predio_mov_ganados.select {|g| g.ganado_id == ganado.ganado_id.to_i}).first
        sum + (g ? g.cant : 0)
      end

      cant = saldo_parcial - ganado.sum_egresos.to_i

      # restar los egresos de ganado enviado a otros predios
      cant -= movimientos.select {|m| m.tipo == "egr"}.inject(0) do |sum, m|
        g = m.inventario_predio_mov_ganados.select {|g| g.ganado_id == ganado.ganado_id.to_i}.first
        sum + (g ? g.cant : 0)
      end

      @inventario_predio.inventario_predio_ganados
        .find_or_create_by_ganado_id(ganado.ganado_id)
        .update_attributes(
          saldo_inicial: saldo_inicial, 
          saldo_parcial: saldo_parcial, 
          cant: cant
        )
    end
    
    # calcular inventario por predio
    @inventario_predio.update_attributes(
      cant: @inventario_predio.inventario_predio_ganados.sum(&:cant),
      cant_may_a: @inventario_predio.inventario_predio_ganados.select {|g| g.ganado.tipo == "may_a"}.sum(&:cant),
      cant_men_a: @inventario_predio.inventario_predio_ganados.select {|g| g.ganado.tipo == "men_a"}.sum(&:cant),
      saldo_p: @inventario_predio.inventario_predio_ganados.sum(&:saldo_parcial),
      saldo_p_may_a: @inventario_predio.inventario_predio_ganados.select {|g| g.ganado.tipo == "may_a"}.sum(&:saldo_parcial),
      saldo_p_men_a: @inventario_predio.inventario_predio_ganados.select {|g| g.ganado.tipo == "men_a"}.sum(&:saldo_parcial),
      saldo_i: @inventario_predio.inventario_predio_ganados.sum(&:saldo_inicial),
      saldo_i_may_a: @inventario_predio.inventario_predio_ganados.select {|g| g.ganado.tipo == "may_a"}.sum(&:saldo_inicial),
      saldo_i_men_a: @inventario_predio.inventario_predio_ganados.select {|g| g.ganado.tipo == "men_a"}.sum(&:saldo_inicial)
    )

    # calcular inventario total
    @inventario.update_attributes(
      cant: @inventario.inventario_predios.sum(&:cant),
      cant_may_a: @inventario.inventario_predios.sum(&:cant_may_a),
      cant_men_a: @inventario.inventario_predios.sum(&:cant_men_a)
    )

    if calc_predio_sec
      @inventario_predio.inventario_predio_movs.select(:predio_sec_id).uniq.map(&:predio_sec_id).each do |predio_id|
        inv_predio_sec = InventarioPredio.get_inventario(predio_id)
        inv_calc = InventarioPredioCalculador.new(inv_predio_sec)
        inv_calc.calculate_totals(false)
      end
    end
  end

  private

  def last_recuento
    mov = Movimiento.joins(:ganados, :movimientos_tipo)
      .where("fecha >= ? and fecha <= ? and movimientos_tipos.tipo='r' and predio_id = ?", 
        @inventario.gestion.desde, @inventario.gestion.hasta, @predio.id)
      .order("fecha desc").first
    return mov
  end

  def update_inventario_predio_movs_totals(inventario_predio)
    inv_movs = inventario_predio.inventario_predio_movs.includes(:inventario_predio_mov_ganados)

    inv_movs.each do |mov|
      # actualizar inventario por predio, mov
      mov.update_attributes(
        cant: mov.inventario_predio_mov_ganados.sum(&:cant),
        cant_may_a: mov.inventario_predio_mov_ganados.select {|g| g.ganado.tipo == "may_a"}.sum(&:cant),
        cant_men_a: mov.inventario_predio_mov_ganados.select {|g| g.ganado.tipo == "men_a"}.sum(&:cant)
      )
    end
  end

  def create_missing_mov_ganados(inventario_predio_mov_ganados)
    missing = Ganado.where("ganados.id not in (?)", inventario_predio_mov_ganados.map(&:ganado_id).push(0))
      .select("ganados.id as ganado_id, 0 as sumatoria")

    missing.each do |ganado|
      inventario_predio_mov_ganados.create(ganado_id: ganado.id, cant: 0)
    end
  end
end