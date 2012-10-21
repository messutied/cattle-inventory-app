# -*- coding: utf-8 -*-

class ReportsController < ApplicationController
  before_filter :require_user
  
  def inventario_mensual
  	@g_grupos      = GanadoGrupo.order("orden asc").find(:all)
  	@ganados       = Ganado.find(:all, :joins => :ganado_grupo, :order => "ganado_grupos.orden asc, ganados.orden asc")

  	@predio        = params[:filtro_predio] || ""
    @gestion_id    = params[:filtro_gestion] || Gestion.gestion_abierta.id

    if @predio != ''

      @gestion       = Gestion.find(@gestion_id)
      @gestion_ant   = @gestion.anterior
    	@info_recuento = Ganado.recuento_info(@predio, @gestion)
    	@m_tipos_ing   = MovimientosTipo.where("tipo = 'i'")
    	@m_tipos_egr   = MovimientosTipo.where("tipo = 'e'")

      rec = @info_recuento[:last]
      fecha_desde = @info_recuento[:mes_actual] ? @info_recuento[:mes_actual].fecha.advance(days: 1) : 
                    @gestion.desde

    	@mov_ingresos = Movimiento.find(
        :all, 
        :select => "DISTINCT movimientos.id, movimientos.predio_id, movimientos.predio_sec_id, "+
                   "movimientos.movimientos_tipo_id, movimientos.fecha",
        :joins => [:movimientos_tipo, :predio, :movimiento_ganados], 
        :group => "movimientos.id, movimientos.predio_id, movimientos.predio_sec_id, "+
                  "movimientos.movimientos_tipo_id, movimientos.fecha",
    		:conditions => [ "movimientos_tipos.tipo='m' and movimientos.predio_sec_id = ? "+
                         "and movimientos.fecha >= ? and movimientos.fecha <= ?", @predio, 
                         fecha_desde, @gestion.hasta  ],
         :order => "movimientos.id"
      )

    	@mov_egresos = Movimiento.find(
        :all, 
        :select => "DISTINCT movimientos.id, movimientos.predio_id, movimientos.predio_sec_id, "+
                   "movimientos.movimientos_tipo_id, movimientos.fecha",
        :joins => [:movimientos_tipo, :predio_sec, :movimiento_ganados],
        :group => "movimientos.id, movimientos.predio_id, movimientos.predio_sec_id, "+
                  "movimientos.movimientos_tipo_id, movimientos.fecha",
    		:conditions => [ "movimientos_tipos.tipo='m' and movimientos.predio_id = ? "+
                         "and movimientos.fecha >= ? and movimientos.fecha <= ?", @predio, 
                         fecha_desde, @gestion.hasta  ],
         :order => "movimientos.id"
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
