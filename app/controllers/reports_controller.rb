class ReportsController < ApplicationController
  def inventario_mensual
  	@g_grupos = GanadoGrupo.order("orden asc").find(:all)
  	@ganados = Ganado.find(:all, :joins => :ganado_grupo, :order => "ganado_grupos.orden asc, ganados.orden asc")

  	@predio = 1 # San Vicente
  	@info_recuento = Ganado.recuento_info(@predio)
  end

end
