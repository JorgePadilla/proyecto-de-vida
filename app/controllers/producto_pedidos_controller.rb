class ProductoPedidosController < ApplicationController
  # GET /producto_pedidos
  # GET /producto_pedidos.json
  def index
    @producto_pedidos = ProductoPedido.includes(:producto).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @producto_pedidos }
    end
  end

  # GET /producto_pedidos/1
  # GET /producto_pedidos/1.json
  def show
    @producto_pedido = ProductoPedido.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @producto_pedido }
    end
  end

  # GET /producto_pedidos/new
  # GET /producto_pedidos/new.json
  def new
    @producto_pedido = ProductoPedido.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producto_pedido }
    end
  end

  # GET /producto_pedidos/1/edit
  def edit
    @producto_pedido = ProductoPedido.find(params[:id])
  end

  def modificarTransito cantidad
		inventario_id=Inventario.where(:producto_id=>@producto_pedido.producto_id)[0].id

    transito=Transito.where(:inventario_id=>inventario_id,
															:asesor_id=>@producto_pedido.pedido.asesor_id)[0]
    if transito==nil
      t=Transito.new
      t.inventario_id = inventario_id
      t.asesor_id = @producto_pedido.pedido.asesor_id
      t.cantidad = -cantidad
      t.save
    else
      transito.cantidad-=cantidad
      transito.save
    end
  end

  # POST /producto_pedidos
  # POST /producto_pedidos.json
  def create
    @producto_pedido = ProductoPedido.new(params[:producto_pedido])

    respond_to do |format|
      if @producto_pedido.save
        modificarTransito @producto_pedido.cantidad
        format.js
        unless request.xhr?
          format.html { redirect_to @producto_pedido.pedido, notice: 'Producto pedido was successfully created.' }
          format.json { render json: @producto_pedido, status: :created, location: @producto_pedido }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @producto_pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /producto_pedidos/1
  # PUT /producto_pedidos/1.json
  def update
    @producto_pedido = ProductoPedido.find(params[:id])

    respond_to do |format|
      if @producto_pedido.update_attributes(params[:producto_pedido])
        format.html { redirect_to @producto_pedido, notice: 'Producto pedido was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @producto_pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /producto_pedidos/1
  # DELETE /producto_pedidos/1.json
  def destroy
    @producto_pedido = ProductoPedido.find(params[:id])
    @pedido=@producto_pedido.pedido;
    @producto_pedido.destroy

    respond_to do |format|
      format.html { redirect_to @pedido}#producto_pedidos_url }
      format.json { head :no_content }
    end
  end
end
