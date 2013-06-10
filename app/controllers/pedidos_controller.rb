class PedidosController < ApplicationController
  # GET /pedidos
  # GET /pedidos.json
  def index
    @pedidos = Pedido.order("fecha_ingreso DESC").limit(15).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pedidos }
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
    @pedido = Pedido.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pedido }
    end
  end

  # GET /pedidos/new
  # GET /pedidos/new.json
  def new
    @pedido = Pedido.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pedido }
    end
  end

  # GET /pedidos/1/edit
  def edit
    @pedido = Pedido.find(params[:id])
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(params[:pedido])

		@pedido.liquidado_asesor=false
		@pedido.liquidado_moderador=false
		@pedido.liquidado_coordinador=false
		@pedido.liquidado_director_comercial=false
		@pedido.liquidado_gerente_comercial=false

    respond_to do |format|
      if @pedido.save

	#crear cuotas
	#crearCuotas @pedido.numero_cuotas, @pedido.id
        i=0
				#if @pedido.abono_inicial>0
				#	i+=1
				#end
        while i<@pedido.numero_cuotas
          c = Cuotum.new
          c.pedido_id=@pedido.id
          c.estado="Pendiente"
          c.num_cuota=i+1
          c.save
          i+=1
        end

        format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
        format.json { render json: @pedido, status: :created, location: @pedido }
      else
        format.html { render action: "new" }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pedidos/1
  # PUT /pedidos/1.json
  def update
    @pedido = Pedido.find(params[:id])

    respond_to do |format|
      if @pedido.update_attributes(params[:pedido])
        format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido = Pedido.find(params[:id])

		#destroy cuotas
		@pedido.cuota.each do |c|
			c.destroy
			c.save
		end

    @pedido.destroy

    respond_to do |format|

			@pedido.cuota.each do |c|
				c.destroy
				c.save
			end

      format.html { redirect_to pedidos_url }
      format.json { head :no_content }
    end
  end


  def buscar
    nombre=params[:nombre_cliente]
    numero=params[:numero_pedido]
    rvi=params[:rvi]
    asesor=params[:asesor]
    if asesor==[""]
      asesor=""
    end
    estado=params[:estado]
    identidad=params[:identidad_cliente]
    fecha_inicio=params[:fecha_inicio]
    fecha_final=params[:fecha_final]

    str=""
    if nombre!=""
      str+="nombre_cliente like "+ "\"" + nombre + "%\" "
    end

    if numero!=""
      if str!=""
        str+= "and "
      end
      str+="numero_pedido = "+ "\"" + numero + "\" "
    end

    if rvi!=""
      if str!=""
        str+= "and "
      end
      str+="rvi = "+ "\"" + rvi + "\" "
    end

    if asesor!=""
      if str!=""
        str+= "and "
      end
      str+="asesor_id = "+ Asesor.find_by_nombre(asesor).id.to_s + " "
    end

    if identidad!=""
      if str!=""
        str+= "and "
      end
      str+="identidad_cliente = "+ "\"" + identidad + "\" "
    end

    if estado!=""
      if str!=""
        str+= "and "
      end
      str+="estado_pedido = "+ "\"" + estado + "\" "
    end

    if str!=""
      str+= "and "
    end
    #str+="fecha_ingreso BETWEEN " + fecha_inicio["(1i)"] + "/" + fecha_inicio["(2i)"] + "/" + fecha_inicio["(3i)"] + " and " + fecha_final["(1i)"] + "/" + fecha_final["(2i)"] + "/" + fecha_final["(3i)"]

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

    str+=" fecha_ingreso BETWEEN '" + anio_inicio + "-" + mes_inicio + "-" + dia_inicio + "' and '" + anio_final + "-" + mes_final + "-" + dia_final + "'"

    #str+=" fecha_ingreso BETWEEN '2012-05-01' and '2012-09-04'"

    @pedidos = Pedido.where(str)

    render :index
  end
end
