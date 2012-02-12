class MovimientosController < ApplicationController
  def index
    @movs = Movimiento.all
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
  end

  def destroy
  end

end
