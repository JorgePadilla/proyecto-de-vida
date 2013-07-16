class CuotaController < ApplicationController

  def getPrimeraCuotaPendiente pedido_id
    pedido=Pedido.find_by_id(pedido_id)
    return pedido.cuota.order("num_cuota").where(:estado=>"Pendiente")[0]
  end

  # GET /cuota
  # GET /cuota.json
  def index

		if params[:id_marcado] != nil
			$cuota_marcada = params[:id_marcado].to_i
		end

    if soyAsistente
      @cuota=[]
      Pedido.all.each do |p|
        c=getPrimeraCuotaPendiente p.id
        if c!=nil
          @cuota.push(c)
        end
      end
    else
      @cuota = Cuotum.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuota }
    end
  end

  # GET /cuota/1
  # GET /cuota/1.json
  def show
    @cuotum = Cuotum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuotum }
    end
  end

  # GET /cuota/new
  # GET /cuota/new.json
  def new
    @cuotum = Cuotum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuotum }
    end
  end

  # GET /cuota/1/edit
  def edit
    @cuotum = Cuotum.find(params[:id])
  end

  # POST /cuota
  # POST /cuota.json
  def create
    @cuotum = Cuotum.new(params[:cuotum])

    respond_to do |format|
      if @cuotum.save
        format.html { redirect_to @cuotum, notice: 'Cuotum was successfully created.' }
        format.json { render json: @cuotum, status: :created, location: @cuotum }
      else
        format.html { render action: "new" }
        format.json { render json: @cuotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuota/1
  # PUT /cuota/1.json
  def update
    @cuotum = Cuotum.find(params[:id])

    respond_to do |format|
      deposito_ant=@cuotum.valor_deposito
      if @cuotum.update_attributes(params[:cuotum])
        if deposito_ant!=@cuotum.valor_deposito
          if aplicaDescuento @cuotum.pedido.fecha_inicio_pago, @cuotum.fecha, @cuotum.pedido.num_dias_descuento, @cuotum.num_cuota
            @cuotum.descuento=@cuotum.pedido.descuento
            @cuotum.save
          else
            @cuotum.descuento=0
            @cuotum.save
          end
          if aplicaMora @cuotum.pedido.fecha_inicio_pago, @cuotum.fecha, @cuotum.pedido.dias_mora, @cuotum.num_cuota
            @cuotum.mora=@cuotum.pedido.mora
            @cuotum.save
          else
            @cuotum.mora=0
            @cuotum.save
          end
        end
        format.html { redirect_to @cuotum, notice: 'Cuotum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuota/1
  # DELETE /cuota/1.json
  def destroy
    @cuotum = Cuotum.find(params[:id])
    @cuotum.destroy

    respond_to do |format|
      format.html { redirect_to cuota_url }
      format.json { head :no_content }
    end
  end

	def getPedidos anio_inicio, mes_inicio, dia_inicio, anio_final, mes_final, dia_final, numero_pedido, rvi, asesor_id, nombre_cliente

    str=""
    if numero_pedido!=""
      str+="numero_pedido = "+ "\"" + numero_pedido + "\" "
    end

    if rvi!=""
      if str!=""
        str+= "and "
      end
      str+="rvi = "+ "\"" + rvi + "\" "
    end

    if nombre_cliente!=""
      if str!=""
        str+= "and "
      end
      str+="nombre_cliente = "+ "\"" + nombre_cliente + "\" "
    end

    if asesor_id!=""
      if str!=""
        str+= "and "
      end
      str+="asesor_id = "+ asesor_id + " "
    end

    if str!=""
      str+= "and "
    end

    if mes_inicio.size==1
      mes_inicio="0"+mes_inicio
    end
    
    if dia_inicio.size==1
      dia_inicio="0"+dia_inicio
    end

    if mes_final.size==1
      mes_final="0"+mes_final
    end

    if dia_final.size==1
      dia_final="0"+dia_final
    end

    str += " fecha_inicio_pago BETWEEN '" + anio_inicio + "-" + mes_inicio + "-" + dia_inicio + "' and '" + anio_final + "-" + mes_final + "-" + dia_final + "'"

    return Pedido.where(str)
	end

  def buscar_cuotas_index

		num_cuota=params[:num_cuota]
		estado=params[:estado]

		@pedidos = getPedidos(params[:anio_inicio], params[:mes_inicio], params[:dia_inicio], params[:anio_final], params[:mes_final], params[:dia_final], params[:numero_pedido], params[:rvi], params[:asesor_id][0], params[:nombre_cliente])

		@cuota = []

		@pedidos.each do |p|
			p.cuota.each do |c|
				if num_cuota == c.num_cuota.to_s && estado == c.estado
					@cuota.push(c)
				end
			end
		end

    render :index

  end

	def marcar
		$cuota_marcada = 35

    if soyAsistente
      @cuota=[]
      Pedido.all.each do |p|
        c=getPrimeraCuotaPendiente p.id
        if c!=nil
          @cuota.push(c)
        end
      end
    else
      @cuota = Cuotum.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuota }
    end
	end

end
