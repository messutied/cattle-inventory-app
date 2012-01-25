class MovimientosController < ApplicationController
  def index
  end

  def show
  end

  def new
    @movimiento = Movimiento.new
    
    @day    = Time.now.day
    @month  = Time.now.month
    @year   = Time.now.year
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
