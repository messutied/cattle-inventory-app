class GestionsController < ApplicationController
  before_filter :require_user

  # GET /gestions
  # GET /gestions.xml
  def index
    @gestions = Gestion.all(:order => "anio desc, mes desc")

    @br = ["Configuración", "Gestión"]

    @gestiones_anteriores = ["Seleccionar..."]

    @gestion_antigua = Gestion.gestion_mas_antigua
    @gestion_ultima = Gestion.gestion_ultima

    @gestion_ultima.anio.downto( @gestion_antigua.anio ) do |anio|
      12.downto(1) do |mes|
        @g = Gestion.find_by_anio_and_mes(anio, mes)
        if @g == nil and (anio != Time.now.year or mes < Time.now.month)
          @gestiones_anteriores.push([anio.to_s+"-"+mes.to_s])
        end
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gestions }
    end
  end

  def abrir
    @gestion_abrir = Gestion.find(params[:id])

    @gestion_abierta = Gestion.find_by_estado("A")
    if @gestion_abierta
      @gestion_abierta.estado = "C"
      @gestion_abierta.save
    end

    @gestion_abrir.estado = "A"
    @gestion_abrir.save

    redirect_to "/gestions"
  end

  def cerrar
    @gestion_cerrar = Gestion.find(params[:id])

    @gestion_actual = Gestion.gestion_actual
    

    @gestion_cerrar.estado = "C"
    @gestion_cerrar.save

    #debugger
    # quiere decir que se esta cerrando el mes en gestion
    # y toca crear una gestion para el siguiente mes
    if @gestion_actual == nil
      year  = Time.now.year
      month = Time.now.month

      @nueva_gestion = Gestion.new({:anio => year, :mes => month, :estado => "A"})
      @nueva_gestion.save
    else
      @gestion_actual.estado = "A"
      @gestion_actual.save
    end

    redirect_to "/gestions"
  end

  # GET /gestions/1
  # GET /gestions/1.xml
  def show
    @gestion = Gestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gestion }
    end
  end

  # GET /gestions/new
  # GET /gestions/new.xml
  def new
    @gestion = Gestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gestion }
    end
  end

  # GET /gestions/1/edit
  def edit
    @gestion = Gestion.find(params[:id])
  end

  def crear_anterior
    gestion = params[:gestion]

    if gestion.include? "/"
      g_mes = gestion.split("/")[0]
      g_anio = gestion.split("/")[1]

      @nueva_gestion = Gestion.new({:anio => g_anio, :mes => g_mes, :estado => "C"})
      @nueva_gestion.save
    end

    redirect_to "/gestions"
  end

  # POST /gestions
  # POST /gestions.xml
  def create
    @gestion = Gestion.new(params[:gestion])

    respond_to do |format|
      if @gestion.save
        format.html { redirect_to(@gestion, :notice => 'Gestion was successfully created.') }
        format.xml  { render :xml => @gestion, :status => :created, :location => @gestion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gestions/1
  # PUT /gestions/1.xml
  def update
    @gestion = Gestion.find(params[:id])

    respond_to do |format|
      if @gestion.update_attributes(params[:gestion])
        format.html { redirect_to(@gestion, :notice => 'Gestion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gestions/1
  # DELETE /gestions/1.xml
  def destroy
    @gestion = Gestion.find(params[:id])
    @gestion.destroy

    @gestion_abierta = Gestion.find_by_estado("A")

    if not @gestion_abierta
      @last = Gestion.gestion_ultima
      @last.estado = "A"
      @last.save
    end

    respond_to do |format|
      format.html { redirect_to(gestions_url) }
      format.xml  { head :ok }
    end
  end
end
