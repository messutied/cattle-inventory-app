# -*- coding: utf-8 -*-

class ReportsController < ApplicationController
  before_filter :require_user
  
  def inventario_mensual
  	@g_grupos      = GanadoGrupo.order("orden asc").find(:all)
  	@ganados       = Ganado.find(:all, :joins => :ganado_grupo, :order => "ganado_grupos.orden asc, ganados.orden asc")

  	@predio        = params[:filtro_predio] != nil ? params[:filtro_predio] : -1 # San Vicente
    @gestion_id    = params[:filtro_gestion] != nil ? params[:filtro_gestion] : Gestion.gestion_abierta.id

    if @predio != ''

      @gestion       = Gestion.find(@gestion_id)
      @gestion_ant   = @gestion.anterior
    	@info_recuento = Ganado.recuento_info(@predio, @gestion)
    	@m_tipos_ing   = MovimientosTipo.where("tipo = 'i'")
    	@m_tipos_egr   = MovimientosTipo.where("tipo = 'e'")

      rec = @info_recuento[:last]
      

    	@mov_ingresos = Movimiento.find(
        :all, 
        :select => "movimientos.id",
        :joins => [:movimientos_tipo, :predio, :movimiento_ganados], 
        :group => "movimientos.id",
    		:conditions => [ "movimientos_tipos.tipo='m' and movimientos.predio_sec_id = ? "+
                         "and movimientos.fecha > ? and movimientos.fecha <= ?", @predio, 
                         @gestion.desde, @gestion.hasta  ]
      )

    	@mov_egresos = Movimiento.find(
        :all, 
        :select => "movimientos.id",
        :joins      => [:movimientos_tipo, :predio_sec, :movimiento_ganados],
        :group      => "movimientos.id",
    		:conditions => [ "movimientos_tipos.tipo='m' and movimientos.predio_id = ? "+
                         "and movimientos.fecha > ? and movimientos.fecha <= ?", @predio, 
                         @gestion.desde, @gestion.hasta  ]
      )


      @ganado_menor_anio = [1, 2]
      @ganado_mayor_anio = -1
      @ganado_todos      = -2


      @presenter = InvMensualReportPresenter.new(
                   @ganados, @info_recuento, @gestion )
    end

    

    @br = ["Reportes", "Inventario Mensual"]
  end

end
