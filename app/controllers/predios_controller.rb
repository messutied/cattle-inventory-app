class PrediosController < ApplicationController
  
  def index
    @predios = Predio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @predios }
    end
  end

  def show
    @predio = Predio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @predio }
    end
  end

  def new
    @predio = Predio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @predio }
    end
  end

  def edit
    @predio = Predio.find(params[:id])
  end

  def create
    @predio = Predio.new(params[:predio])

    respond_to do |format|
      if @predio.save
        format.html { redirect_to @predio, notice: 'Predio was successfully created.' }
        format.json { render json: @predio, status: :created, location: @predio }
      else
        format.html { render action: "new" }
        format.json { render json: @predio.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @predio = Predio.find(params[:id])

    respond_to do |format|
      if @predio.update_attributes(params[:predio])
        format.html { redirect_to @predio, notice: 'Predio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @predio.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @predio = Predio.find(params[:id])
    @predio.destroy

    respond_to do |format|
      format.html { redirect_to predios_url }
      format.json { head :no_content }
    end
  end
end
