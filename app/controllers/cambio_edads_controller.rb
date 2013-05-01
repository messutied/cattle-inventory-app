# encoding: UTF-8

class CambioEdadsController < ApplicationController
  before_filter :require_user

  def index
    @cambio_edad = CambioEdad.new
    @cambio_edades = CambioEdad.all
  end

  def create
    @cambio_edades = CambioEdad.generate_from(params[:cambio_edad])

    if @cambio_edades.save
      redirect_to cambio_edades_path, :notice => "Se generó el Cambio de Edades"
    else
      render action: "index"
    end
  end

  def destroy
    @cambio_edad = CambioEdad.find params[:id]
    @cambio_edad.destroy

    redirect_to cambio_edades_path, notice: "Se eliminó el registro exitosamente"
  end
end