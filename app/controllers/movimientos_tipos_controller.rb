# encoding: UTF-8

class MovimientosTiposController < ApplicationController
  before_filter :require_user
  
  def index
    @movimientos_tipos = MovimientosTipo.order("tipo asc")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movimientos_tipos }
    end
  end

  def show
    @movimientos_tipo = MovimientosTipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movimientos_tipo }
    end
  end

  def new
    @movimientos_tipo = MovimientosTipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movimientos_tipo }
    end
  end

  # GET /movimientos_tipos/1/edit
  def edit
    @movimientos_tipo = MovimientosTipo.find(params[:id])
  end

  def create
    @movimientos_tipo = MovimientosTipo.new(params[:movimientos_tipo])

    respond_to do |format|
      if @movimientos_tipo.save
        format.html { redirect_to(@movimientos_tipo, :notice => 'Movimientos tipo was successfully created.') }
        format.xml  { render :xml => @movimientos_tipo, :status => :created, :location => @movimientos_tipo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movimientos_tipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @movimientos_tipo = MovimientosTipo.find(params[:id])

    respond_to do |format|
      if @movimientos_tipo.update_attributes(params[:movimientos_tipo])
        format.html { redirect_to(@movimientos_tipo, :notice => 'Movimientos tipo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movimientos_tipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @movimientos_tipo = MovimientosTipo.find(params[:id])
    @movimientos_tipo.destroy

    respond_to do |format|
      format.html { redirect_to(movimientos_tipos_url) }
      format.xml  { head :ok }
    end
  end
end
