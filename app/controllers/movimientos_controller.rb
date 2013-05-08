# encoding: UTF-8

class MovimientosController < ApplicationController
  before_filter :require_user
  
  def index
    @type = params[:type]

    @gestion = params["filtro_gestion"] ? 
      Gestion.find(params["filtro_gestion"]) : 
      Gestion.gestion_abierta

    @movs = Movimiento
      .joins(:movimientos_tipo, :predio, :movimiento_ganados)
      .where(gestion_id: @gestion.id)
      .order("fecha desc")
      .select("movimientos.*")


    @filtro_predio = params["filtro_predio"] || "*"
    @filtro_extra = params["filtro_extra"] || "*"

    if @filtro_predio != "*"
      @movs = @movs.where("predio_id=? or predio_sec_id=?", @filtro_predio, @filtro_predio)
    end

    if @filtro_extra == 'P'
      @movs = @movs.where("movimiento_ganados.cant > movimiento_ganados.cant_sec")
    end

    if @filtro_extra == 'I'
      @movs = @movs.where("movimiento_ganados.cant_sec IS NULL")
    end

    if @type == "mov"
      @movs = @movs.where("movimientos_tipos.tipo = 'm'")
    elsif @type == "in_eg"
      @movs = @movs.where("movimientos_tipos.tipo = 'i' or movimientos_tipos.tipo = 'e'")
    elsif @type == "rec"
      @movs = @movs.where("movimientos_tipos.tipo = 'r'")
    else
    end
  end

  def show
    @movimiento = Movimiento.find(params[:id])
    @type = @movimiento.type_str
  end

  def new
    @movimiento = Movimiento.new
    @movimiento.movimiento_ganados.build

    @type = params[:type]
  end

  def create
    @movimiento = Movimiento.new(params[:movimiento])
    @movimiento.parse_fecha!(params[:dia])
    @type = params[:type]

    if @movimiento.save()
      redirect_to(@movimiento, :notice => 'Se creo el movimiento.')
    else
      render :action => "new"
    end
  end

  def edit
    @movimiento = Movimiento.find(params[:id])
    @type = @movimiento.type_str

    print @movimiento.movimiento_ganados[0].to_json
  end

  def update
    @movimiento = Movimiento.find(params[:id])
    @type = @movimiento.type_str
    @movimiento.parse_fecha!(params[:dia])

    if @movimiento.update_attributes(params[:movimiento])
      redirect_to @movimiento, :notice => "Se guardó el movimiento"
    else
      render :action => "edit"
    end
  end

  def destroy
    @mov = Movimiento.find(params[:id])
    @mov.destroy

    case @mov.type_str
      when "in_eg" 
        redirect_to "/ingreso-egreso/list"
      when "mov" 
        redirect_to "/movimiento/list"
      else 
        redirect_to "/recuento/list"
    end
  end

end
