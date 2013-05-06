# encoding: UTF-8

class ConfiguracionsController < ApplicationController
  before_filter :require_user
  helper_method :config_path

  def cambio_edad
    @configuracion = Configuracion.first_or_initialize
    @configuracion.configuracion_cambio_edads.build

    render "cambio_animal"
  end

  def descartes
    @configuracion = Configuracion.first_or_initialize
    @configuracion.configuracion_descartes.build

    render "cambio_animal"
  end

  def create
    @configuracion = Configuracion.new(params[:configuracion])

    if @configuracion.save
      redirect_to config_path(params[:config_saved]), :notice => "Se guardó la configuracion correctamete"
    else
      render action: params[:config_saved]
    end
  end

  def update
    @configuracion = Configuracion.find params[:id]
    @configuracion.update_attributes params[:configuracion]

    if @configuracion.save
      redirect_to config_path(params[:config_saved]), :notice => "Se guardó la configuracion correctamete"
    else
      render action: params[:config_saved]
    end
  end

  private

  def config_path(from_action)
    case from_action
    when "cambio_edad"
      return config_cambio_edad_path
    when "descartes"
      return config_descartes_path
    end
  end
end