class MovimientosController < ApplicationController
  def index
    @type = params[:type]
    if @type == "mov"
      @movs = Movimiento.find(:all, :joins => :movimientos_tipo, 
        :conditions => "movimientos_tipos.tipo = 'm'", 
        :order => "fecha desc")
    else
      @movs = Movimiento.find(:all, :joins => :movimientos_tipo, 
        :conditions => "movimientos_tipos.tipo = 'i' or movimientos_tipos.tipo = 'e'", 
        :order => "fecha desc")
    end
  end

  def show
  end

  def new
    @movimiento = Movimiento.new
    @movimiento.movimiento_ganados.build

    @type = params[:type]
  end

  def create
    @movimiento = Movimiento.new(params[:movimiento])
    @movimiento.parse_fecha(params[:anio], params[:mes], params[:dia])
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

    if @movimiento.update_attributes(params[:movimiento])
      redirect_to @movimiento, :notice => "Se guardó el movimiento"
    else
      render :action => "edit"
    end
  end

  def destroy
    @mov = Movimiento.find(params[:id])
    @mov.destroy

    redirect_to movimientos_url
  end

end
