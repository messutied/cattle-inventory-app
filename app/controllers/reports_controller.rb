class ReportsController < ApplicationController
  def inventario_mensual
  	@g_grupos = GanadoGrupo.find(:all)

  	@predio = 1 # San Vicente
  end

end
