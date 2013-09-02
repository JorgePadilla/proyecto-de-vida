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
		@liquidacion_comision.empleado_id=$empleado_id
		@liquidacion_comision.rol=$rol
		@liquidacion_comision.monto=$monto
		@liquidacion_comision.fecha_inicio=$fecha_inicio
		@liquidacion_comision.fecha_final=$fecha_final

		if @liquidacion_comision.rol=="asesor"
			#marcar pedidos como liquidados de asesor
		  @pedidos_credito = $pedidos_credito
			@pedidos_credito.each do |pedido|
				pedido.liquidado_asesor=true
				pedido.save
			end

		  @pedidos_contado_asesor = $pedidos_contado_asesor
			@pedidos_contado_asesor.each do |pedido|
				pedido.liquidado_asesor=true
				pedido.save
			end

		  @pedidos_contado_empresa = $pedidos_contado_empresa
			@pedidos_contado_empresa.each do |pedido|
				pedido.liquidado_asesor=true
				pedido.save
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
    str = "asesor_id = " + asesor_id.to_s + str_fecha
    pedidos = Pedido.where(str)
		return pedidos
	end

  def getPedidosSinLiquidarFromModerador asesor_id, str_fecha
    str = "asesor_id = " + asesor_id.to_s + " AND liquidado_moderador != 1" + str_fecha
    pedidos = Pedido.where(str)
		return pedidos
	end

  def getPedidosSinLiquidarFromCoordinador asesor_id, str_fecha
    str = "asesor_id = " + asesor_id.to_s + " AND liquidado_coordinador != 1" + str_fecha
    pedidos = Pedido.where(str)
		return pedidos
	end

  def getPedidosSinLiquidarFromDirectorComercial asesor_id, str_fecha
    str = "asesor_id = " + asesor_id.to_s + " AND liquidado_director_comercial != 1" + str_fecha
    pedidos = Pedido.where(str)
		return pedidos
	end

  def getPedidosSinLiquidarFromGerenteComercial asesor_id, str_fecha
    str = "asesor_id = " + asesor_id.to_s + " AND liquidado_gerente_comercial != 1" + str_fecha
    pedidos = Pedido.where(str)
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

    @pedidos_credito=[]
    @pedidos_contado_asesor=[]
    @pedidos_contado_empresa=[]

		pedidos_temp = getPedidosSinLiquidarFromAsesor asesor_id, str_fecha

		@monto_credito=0
		@monto_contado_asesor=0
		@monto_contado_empresa=0
		pedidos_temp.each do |pedido|
			if pedido.cuota.first != nil
				if !pedido.liquidado_asesor
					if pedido.cuota.first.estado=="Pagado" && pedido.tipo_pago=="Credito"
						@pedidos_credito.push(pedido)
						if pedido.valor_credito!=nil
							@monto_credito+=pedido.valor_credito
						end
					end

					if pedido.cuota.first.estado=="Pagado" && pedido.tipo_pago=="Contado asesor"
						@pedidos_credito.push(pedido)
						if pedido.valor_credito!=nil
							@monto_contado_asesor+=pedido.valor_credito
						end
					end

					if pedido.cuota.first.estado=="Pagado" && pedido.tipo_pago=="Contado empresa"
						@pedidos_credito.push(pedido)
						if pedido.valor_credito!=nil
							@monto_contado_empresa+=pedido.valor_credito
						end
					end
				end
			end
		end

		@fecha_inicio = Date.new(anio_inicio.to_i,mes_inicio.to_i,dia_inicio.to_i)
		@fecha_final = Date.new(anio_final.to_i,mes_final.to_i,dia_final.to_i)

    @liquidacion_comision = LiquidacionComision.new
		@asesor_id=asesor_id
		@liquidacion_comision.rol="asesor"
		@liquidacion_comision.fecha=Date.today

		@empleado=Asesor.find_by_id(asesor_id).nombre

		render :new
	end

	def buscar_liquidacion_moderador
		moderador_id=params[:dsfg][:moderador_id]

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

		@pedidos_credito=[]
		moderador=Moderador.find_by_id(moderador_id)
		@monto=0
		moderador.asesors.each do |asesor|
		  pedidos_temp = getPedidosSinLiquidarFromModerador asesor.id, str_fecha
			pedidos_temp.each do |pedido|
				@pedidos_credito.push(pedido)
				if pedido.valor_credito!=nil
					@monto+=pedido.valor_credito
				end
			end
		end

    @liquidacion_comision = LiquidacionComision.new
		@asesor_id=moderador_id
		@liquidacion_comision.rol="moderador"
		@liquidacion_comision.fecha=Date.today
		@empleado=moderador.nombre


		@fecha_inicio=@string_fecha_inicio
		@fecha_final=@string_fecha_final

		render :new
	end

	def buscar_liquidacion_coordinador
		coordinador_id=params[:dsfg][:coordinador_id]

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

		@pedidos_credito=[]
		coordinador=Coordinador.find_by_id(coordinador_id)
		@monto=0
		coordinador.moderadors.each do |moderador|		
			moderador.asesors.each do |asesor|
				pedidos_temp = getPedidosSinLiquidarFromCoordinador asesor.id, str_fecha
				pedidos_temp.each do |pedido|
					@pedidos_credito.push(pedido)
					if pedido.valor_credito!=nil
						@monto+=pedido.valor_credito
					end
				end
			end
		end

    @liquidacion_comision = LiquidacionComision.new
		@asesor_id=coordinador_id
		@liquidacion_comision.rol="coordinador"
		@liquidacion_comision.fecha=Date.today
		@empleado=coordinador.nombre


		@fecha_inicio=@string_fecha_inicio
		@fecha_final=@string_fecha_final

		render :new
	end

	def buscar_liquidacion_director_comercial
		director_comercial_id=params[:dsfg][:director_comercial_id]

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

		@pedidos_credito=[]
		director_comercial=DirectorComercial.find_by_id(director_comercial_id)
		@monto=0
		director_comercial.coordinadors.each do |coordinador|		
			coordinador.moderadors.each do |moderador|		
				moderador.asesors.each do |asesor|
					pedidos_temp = getPedidosSinLiquidarFromDirectorComercial asesor.id, str_fecha
					pedidos_temp.each do |pedido|
						@pedidos_credito.push(pedido)
						if pedido.valor_credito!=nil
							@monto+=pedido.valor_credito
						end
					end
				end
			end
		end

    @liquidacion_comision = LiquidacionComision.new
		@asesor_id=director_comercial_id
		@liquidacion_comision.rol="director_comercial"
		@liquidacion_comision.fecha=Date.today
		@empleado=director_comercial.nombre


		@fecha_inicio=@string_fecha_inicio
		@fecha_final=@string_fecha_final

		render :new
	end

	def buscar_liquidacion_gerente_comercial
		gerente_comercial_id=params[:dsfg][:gerente_comercial_id]

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

		@pedidos_credito=[]
		gerente_comercial=GerenteComercial.find_by_id(gerente_comercial_id)
		@monto=0
		gerente_comercial.director_comercials.each do |director_comercial|
			director_comercial.coordinadors.each do |coordinador|
				coordinador.moderadors.each do |moderador|
					moderador.asesors.each do |asesor|
						pedidos_temp = getPedidosSinLiquidarFromGerenteComercial asesor.id, str_fecha
						pedidos_temp.each do |pedido|
							@pedidos_credito.push(pedido)
							if pedido.valor_credito!=nil
								@monto+=pedido.valor_credito
							end
						end
					end
				end
			end
		end

    @liquidacion_comision = LiquidacionComision.new
		@asesor_id=gerente_comercial_id
		@liquidacion_comision.rol="gerente_comercial"
		@liquidacion_comision.fecha=Date.today
		@empleado=gerente_comercial.nombre


		@fecha_inicio=@string_fecha_inicio
		@fecha_final=@string_fecha_final

		render :new
	end
end
