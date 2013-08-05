class LiquidacionComisionsController < ApplicationController
  # GET /liquidacion_comisions
  # GET /liquidacion_comisions.json
  def index
    @liquidacion_comisions = LiquidacionComision.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @liquidacion_comisions }
    end
  end

  # GET /liquidacion_comisions/1
  # GET /liquidacion_comisions/1.json
  def show
    @liquidacion_comision = LiquidacionComision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @liquidacion_comision }
    end
  end

  # GET /liquidacion_comisions/new
  # GET /liquidacion_comisions/new.json
  def new
    @liquidacion_comision = LiquidacionComision.new
		@liquidacion_comision.rol="asesor"
		@liquidacion_comision.fecha=Date.today

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @liquidacion_comision }
    end
  end

  # GET /liquidacion_comisions/1/edit
  def edit
    @liquidacion_comision = LiquidacionComision.find(params[:id])
  end

  # POST /liquidacion_comisions
  # POST /liquidacion_comisions.json
  def create
    @liquidacion_comision = LiquidacionComision.new(params[:liquidacion_comision])

		#marcar pedidos como liquidados
    str = "asesor_id = " + @asesor_id + " AND liquidado_asesor != 1"
    @pedidos = Pedido.where(str)
		@monto=0
		@pedidos.each do |pedido|
			if pedido.valor_credito!=nil
				@monto+=pedido.valor_credito
			end
		end

    respond_to do |format|
      if @liquidacion_comision.save
        format.html { redirect_to @liquidacion_comision, notice: 'Liquidacion comision was successfully created.' }
        format.json { render json: @liquidacion_comision, status: :created, location: @liquidacion_comision }
      else
        format.html { render action: "new" }
        format.json { render json: @liquidacion_comision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /liquidacion_comisions/1
  # PUT /liquidacion_comisions/1.json
  def update
    @liquidacion_comision = LiquidacionComision.find(params[:id])

    respond_to do |format|
      if @liquidacion_comision.update_attributes(params[:liquidacion_comision])
        format.html { redirect_to @liquidacion_comision, notice: 'Liquidacion comision was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @liquidacion_comision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liquidacion_comisions/1
  # DELETE /liquidacion_comisions/1.json
  def destroy
    @liquidacion_comision = LiquidacionComision.find(params[:id])
    @liquidacion_comision.destroy

    respond_to do |format|
      format.html { redirect_to liquidacion_comisions_url }
      format.json { head :no_content }
    end
  end

  def getPedidosSinLiquidarFromAsesor asesor_id, str_fecha
    str = "asesor_id = " + asesor_id + " AND liquidado_asesor != 1" + str_fecha
    pedidos = Pedido.where(str)
		return pedidos
	end

  def getPedidosSinLiquidarFromModerador moderador_id
		moderador = Moderador.find_by_id(moderador_id)
		pedidos=[]
		moderador.asesors.each do |asesor|
  	  str = "asesor_id = " + asesor.id.to_s() + " AND liquidado_moderador != 1"
			Pedido.where(str).each do |p_temp|
		    pedidos.push(p_temp)
			end
		end

		return pedidos
	end

	def buscar_liquidacion_asesor
		asesor_id=params[:dsfg][:asesor_id]

    anio_inicio=params[:anio_inicio]
    mes_inicio=params[:mes_inicio]
    if mes_inicio.size==1
      mes_inicio="0"+mes_inicio
    end
    dia_inicio=params[:dia_inicio]
    if dia_inicio.size==1
      dia_inicio="0"+dia_inicio
    end

    anio_final=params[:anio_final]
    mes_final=params[:mes_final]
    if mes_final.size==1
      mes_final="0"+mes_final
    end
    dia_final=params[:dia_final]
    if dia_final.size==1
      dia_final="0"+dia_final
    end

    str_fecha=" and fecha_ingreso BETWEEN '" + anio_inicio + "-" + mes_inicio + "-" + dia_inicio + "' and '" + anio_final + "-" + mes_final + "-" + dia_final + "'"

    @pedidos = getPedidosSinLiquidarFromAsesor asesor_id, str_fecha

		@monto=0
		@pedidos.each do |pedido|
			if pedido.valor_credito!=nil
				@monto+=pedido.valor_credito
			end
		end

    @liquidacion_comision = LiquidacionComision.new
		@asesor_id=asesor_id
		@liquidacion_comision.rol="asesor"
		@liquidacion_comision.fecha=Date.today

		@empleado=Asesor.find_by_id(asesor_id).nombre

		@fecha_inicio=@string_fecha_inicio
		@fecha_final=@string_fecha_final

		render :new
	end

	def buscar_liquidacion_moderador
		asesor_id=params[:dsfg][:asesor_id]

    @pedidos = getPedidosSinLiquidarFromModerador asesor_id

		@monto=0
		@pedidos.each do |pedido|
			if pedido.valor_credito!=nil
				@monto+=pedido.valor_credito
			end
		end

    @liquidacion_comision = LiquidacionComision.new
		@asesor_id=asesor_id
		@liquidacion_comision.rol="moderador"
		@liquidacion_comision.fecha=Date.today

		@empleado=Moderador.find_by_id(asesor_id).nombre

		@fecha_inicio=@string_fecha_inicio
		@fecha_final=@string_fecha_final

		render :liquidacion_moderador
	end
end
