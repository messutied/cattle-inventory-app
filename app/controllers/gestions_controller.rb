# encoding: UTF-8

class GestionsController < ApplicationController
  #before_filter :require_user

  # GET /gestions
  # GET /gestions.xml
  def index
    @gestions = Gestion.all(:order => "anio desc, mes desc")
    @gestion = Gestion.new

    @br = ["Configuración", "Gestión"]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gestions }
    end
  end

  def abrir
    @gestion = Gestion.find(params[:id])
    @gestion.abrir

    redirect_to "/gestions"
  end

  def cerrar
    Gestion.gestion_actual.abrir

    redirect_to "/gestions"
  end

  # GET /gestions/1
  # GET /gestions/1.xml
  def show
    @gestion = Gestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /gestions/new
  # GET /gestions/new.xml
  def new
    @gestion = Gestion.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /gestions/1/edit
  def edit
    @gestion = Gestion.find(params[:id])
  end

  def crear_anterior
    gestion = params[:gestion]

    respond_to do |format|
      if gestion.include? "-"
        g_anio = gestion.split("-")[0]
        g_mes = gestion.split("-")[1]

        @nueva_gestion = Gestion.new({:anio => g_anio, :mes => g_mes, :estado => "C"})
        if @nueva_gestion.save
          format.html { redirect_to "/gestions" }
        else
          flash[:error] = "No se pudo crear la gestión"
          format.html { redirect_to "/gestions" }
        end
      end
    end
  end

  def create
    @gestion = Gestion.new(params[:gestion])

    respond_to do |format|
      if @gestion.save
        format.html { redirect_to(@gestion, :notice => 'Gestion was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @gestion = Gestion.find(params[:id])

    respond_to do |format|
      if @gestion.update_attributes(params[:gestion])
        format.html { redirect_to(@gestion, :notice => 'Gestion was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    Gestion.find(params[:id]).destroy
    Gestion.gestion_ultima.abrir if not Gestion.gestion_abierta

    respond_to do |format|
      format.html { redirect_to(gestions_url) }
    end
  end
end
