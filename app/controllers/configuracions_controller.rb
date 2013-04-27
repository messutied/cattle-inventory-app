# encoding: UTF-8

class ConfiguracionsController < ApplicationController
  before_filter :require_user

  def cambio_edad
    @configuracion = Configuracion.first || Configuracion.new
    @configuracion.configuracion_cambio_edads.build

    render "cambio_animal"
  end

  def descartes
    @configuracion = Configuracion.first || Configuracion.new
    @configuracion.configuracion_descartes.build

    render "cambio_animal"
  end

  def create
    @configuracion = Configuracion.new(params[:configuracion])

    if @configuracion.save
      redirect_to action: params[:config_saved], :notice => "Se guardó la configuracion correctamete"
    else
      render action: params[:config_saved]
    end
  end

  def update
    @configuracion = Configuracion.find params[:id]
    @configuracion.update_attributes params[:configuracion]

    if @configuracion.save
      redirect_to action: params[:config_saved], :notice => "Se guardó la configuracion correctamete"
    else
      render action: params[:config_saved]
    end
  end
end