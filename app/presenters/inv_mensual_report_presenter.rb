class InvMensualReportPresenter

  @@ganado_menor_anio = [1, 2]
  @@ganado_mayor_anio = -1
  @@ganado_todos      = -2

  def initialize(ganados, info_recuento, gestion)
    @ganados       = ganados
    @info_recuento = info_recuento
    @gestion       = gestion
    @gestion_ant   = gestion.anterior
  end

  def saldo_mes(predio, _gestion=nil)
    gestion = _gestion || @gestion

    @ganados.each do |g|
      yield( Movimiento.saldo_mes(predio, @info_recuento, gestion, g.id) )
    end

    yield( Movimiento.saldo_mes(predio, @info_recuento, gestion, @@ganado_menor_anio) )
    yield( Movimiento.saldo_mes(predio, @info_recuento, gestion, @@ganado_mayor_anio) )
    yield( Movimiento.saldo_mes(predio, @info_recuento, gestion, @@ganado_todos) )
  end

  def saldo_mes_ant(predio, _gestion=nil)
    gestion = _gestion || @gestion_ant

    saldo_mes(predio, gestion) {|g| yield(g) }
  end

  def saldo_parcial_ingresos(predio, _gestion=nil)
    gestion = _gestion || @gestion

    @ganados.each do |g|
      yield( Movimiento.saldo_parcial_ingresos(predio, @info_recuento, gestion, g.id) )
    end

    yield( Movimiento.saldo_parcial_ingresos(predio, @info_recuento, gestion, @@ganado_menor_anio) )
    yield( Movimiento.saldo_parcial_ingresos(predio, @info_recuento, gestion, @@ganado_mayor_anio) )
    yield( Movimiento.saldo_parcial_ingresos(predio, @info_recuento, gestion, @@ganado_todos) )
  end

  def cant_in_eg(predio, m_tipo_id, _gestion=nil)
    gestion = _gestion || @gestion

    @ganados.each do |g|
      yield( Movimiento.cant_ing_egr(predio, @info_recuento, gestion, m_tipo_id, g.id) )
    end

    yield( Movimiento.cant_ing_egr(predio, @info_recuento, gestion, m_tipo_id, @@ganado_menor_anio) )
    yield( Movimiento.cant_ing_egr(predio, @info_recuento, gestion, m_tipo_id, @@ganado_mayor_anio) )
    yield( Movimiento.cant_ing_egr(predio, @info_recuento, gestion, m_tipo_id, @@ganado_todos) )
  end
end