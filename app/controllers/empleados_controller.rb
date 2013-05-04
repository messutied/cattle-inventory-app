class EmpleadosController < ApplicationController

  def index
    @empleados = Empleado.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @empleados }
    end
  end

  def show
    @empleado = Empleado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @empleado }
    end
  end

  def new
    @empleado = Empleado.new

    @remote = request.xhr?

    respond_to do |format|
      if @remote
        format.html { render :layout => false }
      else
        format.html # new.html.erb
        format.json { render json: @empleado }
      end
    end
  end

  def edit
    @empleado = Empleado.find(params[:id])
  end

  def create
    @empleado = Empleado.new(params[:empleado])

    respond_to do |format|
      if @empleado.save
        format.html do 
          if request.xhr?
            render :json => {error: false, empleado: @empleado}
          else
            redirect_to @empleado, notice: 'Empleado was successfully created.'
          end
        end
        format.json { render json: @empleado, status: :created, location: @empleado }
      else
        if request.xhr?
          render :json => {error: true, errors: @empleado.errors}
        else
          format.html { render action: "new" }
          format.json { render json: @empleado.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @empleado = Empleado.find(params[:id])

    respond_to do |format|
      if @empleado.update_attributes(params[:empleado])
        format.html { redirect_to @empleado, notice: 'Empleado was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @empleado = Empleado.find(params[:id])
    @empleado.destroy

    respond_to do |format|
      format.html { redirect_to empleados_url }
      format.json { head :no_content }
    end
  end
end
