# encoding: UTF-8

class HomeController < ApplicationController
  before_filter :require_user

  def index
  	@gestion = Gestion.gestion_abierta
    @perdidas = Movimiento.movimientos_perdidas

    @perdidas_info = @perdidas
      .select("movimientos.id, SUM(movimiento_ganados.cant-movimiento_ganados.cant_sec) as perdida, "+
        "movimientos.fecha, movimientos.detalle, predios.nombre as predio_nombre, "+
        "predio_secs_movimientos.nombre as predio_sec_nombre")
      .joins(:predio, :predio_sec)
      .group("movimientos.id, movimientos.fecha, movimientos.detalle, predios.nombre, "+
        "predio_secs_movimientos.nombre")

    @perdidas_count = @perdidas
      .select("SUM(movimiento_ganados.cant-movimiento_ganados.cant_sec) as count")
      .first.count || 0

    @incompletos = Movimiento.movimientos_incompletos
    @incompletos_info = @incompletos
    @incompletos_count = Movimiento.movimientos_incompletos.count
  end

end
