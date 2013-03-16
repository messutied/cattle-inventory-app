class InventarioPredioCalculador
  def initialize(inventario_predio)
    @inventario_predio = inventario_predio
    @inventario        = inventario_predio.inventario
    @predio            = inventario_predio.predio
    @recuento          = last_recuento
    @fecha_inicio      = @recuento ? @recuento.fecha.advance(days: 1) : @inventario.gestion.desde
    @fecha_fin         = @inventario.gestion.hasta
  end

  def calculate_ingr_egr_ganado_predio
    mov = Movimiento.joins(:ganados, :movimientos_tipo)
          .select("movimientos_tipos.id as movimiento_tipo_id, ganados.id as ganado_id, sum(movimiento_ganados.cant) as sumatoria")
          .where("movimientos_tipos.tipo in ('i', 'e') and movimientos.predio_id = ? and fecha >= ? and fecha <= ?", 
                 @predio.id, @fecha_inicio, @fecha_fin)
          .group("movimientos_tipos.id, ganados.id")
          .order("movimientos_tipos.tipo asc")


    mov.each do |ingr_egr|
      inv_predio_ingr_egr = @inventario_predio.inventario_predio_ingr_egrs
        .find_or_create_by_movimientos_tipo_id(ingr_egr.movimiento_tipo_id)

      ganado = inv_predio_ingr_egr.inventario_predio_ingr_egr_ganados
        .find_or_initialize_by_ganado_id(ingr_egr.ganado_id)

      # actualizar inventario por predio, ingr/egr, por ganado
      ganado.update_attributes(cant: ingr_egr.sumatoria)
    end

    inv_ingr_egr = @inventario_predio.inventario_predio_ingr_egrs

    inv_ingr_egr.each do |ingr_egr|
      # actualizar inventario por predio, ingr/egr
      ingr_egr.cant = ingr_egr.inventario_predio_ingr_egr_ganados.sum(&:cant)
      ingr_egr.save
    end
  end

  def calculate_totals
    # calcular inventario por predio por ganado
    saldos_mes_actual = Movimiento.joins(:ganados, :movimientos_tipo)
          .select("ganados.id as ganado_id, "+
            "sum(case when movimientos_tipos.tipo='e' then -1*movimiento_ganados.cant else movimiento_ganados.cant end) as sumatoria")
          .where("movimientos_tipos.tipo in ('i', 'e') and movimientos.predio_id = ? and fecha >= ? and fecha <= ?", 
                 @predio.id, @fecha_inicio, @fecha_fin)
          .group("ganados.id")

    saldos_mes_actual.each do |ganado|
      cant = ganado.sumatoria.to_i

      if not @recuento # si no hubo un recuento esta gestion, tomar en cuenta la anterior gestion
        if @inventario.gestion.anterior
          inv = @inventario.gestion.anterior.get_inventario.get_inventario_predio(@predio.id)
          inv_ganado = inv.inventario_predio_ganados.find_by_ganado_id(ganado.ganado_id)
          cant += inv_ganado.cant if inv_ganado
        end
      end
      # si hubo un recuento esta gestion, se ignoran las gestiones anteriores

      @inventario_predio.inventario_predio_ganados
        .find_or_create_by_ganado_id(ganado.ganado_id)
        .update_attributes(cant: cant)
    end
    
    # calcular inventario por predio
    @inventario_predio.update_attributes(cant: @inventario_predio.inventario_predio_ganados.sum(&:cant))

    # calcular inventario total
    @inventario.update_attributes(cant: @inventario.inventario_predios.sum(&:cant))
  end

  private

  def last_recuento
    # mov = Movimiento.joins(:ganados).where("fecha >= ? and fecha <= ? and movimientos_tipo_id=9 and predio_id = ?", @inventario.gestion.desde, @inventario.gestion.hasta, @predio.id).order("fecha desc").first

    mov = Movimiento.find(
      :first, 
      :joins => :ganados, 
      :conditions => ["fecha >= ? and fecha <= ? and movimientos_tipo_id=9 and predio_id = ?", 
      @inventario.gestion.desde, @inventario.gestion.hasta, @predio.id],
      :order => "fecha desc",
      :limit => 1
      )
  end
end