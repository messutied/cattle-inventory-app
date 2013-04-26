# encoding: UTF-8

class DescartesController < ApplicationController
  before_filter :require_user

  def new
    @descarte = Descarte.new
  end

  def create
    @descarte = Descarte.new_with_descarte(params[:descarte], params[:ganado_id], params[:cant])
    @descarte.parse_fecha!(params[:dia])

    if @descarte.save
      redirect_to @descarte, :notice => "Se guardó el descarte de ganado"
    else
      render action: "edit"
    end
  end

  def edit
    @descarte = Descarte.find(params[:id])
  end

  def index
    @descartes = Descarte.all
  end

  def show
    @descarte = Descarte.find(params[:id])
  end
end