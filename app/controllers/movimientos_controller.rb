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
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
