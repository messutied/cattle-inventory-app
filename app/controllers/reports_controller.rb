# encoding: UTF-8

class ReportsController < ApplicationController
  before_filter :require_user
  
  def inventario_mensual
  	@g_grupos = GanadoGrupo.all
  	@ganados = Ganado.all
  	@predio = params[:filtro_predio] || ""
    @gestion_id = params[:filtro_gestion] || Gestion.gestion_abierta.id

    if @predio != ''

      @gestion = Gestion.find(@gestion_id)
      @gestion_ant = @gestion.anterior
    	
      @inv_predio = InventarioPredio.get_inventario(@predio, @gestion)
      @ip_ganados = @inv_predio.inventario_predio_ganados
    end

    @br = ["Reportes", "Inventario Mensual"]
  end

end
