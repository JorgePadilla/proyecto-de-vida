class PagoCuotaController < ApplicationController
  # GET /pago_cuota
  # GET /pago_cuota.json
  def index
    @pago_cuota = PagoCuotum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pago_cuota }
    end
  end

  # GET /pago_cuota/1
  # GET /pago_cuota/1.json
  def show
    @pago_cuotum = PagoCuotum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pago_cuotum }
    end
  end

  # GET /pago_cuota/new
  # GET /pago_cuota/new.json
  def new
    @pago_cuotum = PagoCuotum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pago_cuotum }
    end
  end

  # GET /pago_cuota/1/edit
  def edit
    @pago_cuotum = PagoCuotum.find(params[:id])
  end

  # POST /pago_cuota
  # POST /pago_cuota.json
  def create
    @pago_cuotum = PagoCuotum.new(params[:pago_cuotum])

    respond_to do |format|
      if @pago_cuotum.save
        format.js
        unless request.xhr?
		      format.html { redirect_to @pago_cuotum, notice: 'Pago cuotum was successfully created.' }
		      format.json { render json: @pago_cuotum, status: :created, location: @pago_cuotum }
				end
      else
        format.html { render action: "new" }
        format.json { render json: @pago_cuotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pago_cuota/1
  # PUT /pago_cuota/1.json
  def update
    @pago_cuotum = PagoCuotum.find(params[:id])

    respond_to do |format|
      if @pago_cuotum.update_attributes(params[:pago_cuotum])
        format.html { redirect_to @pago_cuotum, notice: 'Pago cuotum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pago_cuotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pago_cuota/1
  # DELETE /pago_cuota/1.json
  def destroy
    @pago_cuotum = PagoCuotum.find(params[:id])
    @pago_cuotum.destroy

    respond_to do |format|
      format.html { redirect_to pago_cuota_url }
      format.json { head :no_content }
    end
  end
end
