class MovimientosController < ApplicationController
  def index
  end

  def show
  end

  def new
    @movimiento = Movimiento.new

    @movimiento.movimiento_ganados.build
  end

  def create
    @movimiento = Movimiento.new(params[:movimiento])

    if @movimiento.save()
      redirect_to(@movimiento, :notice => 'Se creo el movimiento.')
    else
      render :action => "new", :type => params[:type]
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
