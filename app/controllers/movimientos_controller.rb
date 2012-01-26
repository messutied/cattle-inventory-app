class MovimientosController < ApplicationController
  def index
  end

  def show
  end

  def new
    @movimiento = Movimiento.new

    3.times do
      @movimiento.movimiento_ganados.build
    end
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
