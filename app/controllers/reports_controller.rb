class ReportsController < ApplicationController
  def inventario_mensual
  	@g_grupos = GanadoGrupo.order("orden asc").find(:all)
  	@ganados = Ganado.find(:all, :joins => :ganado_grupo, :order => "ganado_grupos.orden asc, ganados.orden asc")

  	@predio = 1 # San Vicente
  	@info_recuento = Ganado.recuento_info(@predio)
  	@m_tipos_ing = MovimientosTipo.where("tipo = 'i'")
  	@m_tipos_egr = MovimientosTipo.where("tipo = 'e'")

  	@mov_ingresos = Movimiento.find(:all, :joins => [:movimientos_tipo, :predio, :movimiento_ganados], 
  		:conditions => ["movimientos_tipos.tipo='m' and movimientos.predio_sec_id = ?", @predio])

  	@mov_egresos = Movimiento.find(:all, :joins => [:movimientos_tipo, :predio_sec, :movimiento_ganados], 
  		:conditions => ["movimientos_tipos.tipo='m' and movimientos.predio_id = ?", @predio])

    @menor_anio = 0
  end

end
