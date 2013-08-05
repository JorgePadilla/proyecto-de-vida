module ApplicationHelper
  def soyAdministrador
    if current_user == nil
      return false
    end
    if current_user.rol.id == 1
      return true
    end
    return false
  end
  def soyReferenciacion
    if current_user == nil
      return false
    end
    if current_user.rol.id == 2
      return true
    end
    return false
  end
  def soyAsistente
    if current_user == nil
      return false
    end
    if current_user.rol.id == 3
      return true
    end
    return false
  end
  def soyCobranza
    if current_user == nil
      return false
    end
    if current_user.rol.id == 4
      return true
    end
    return false
  end

  def usuariosAdministrador
    return Usuario.where(:rol_id=>1)
  end
  def usuariosReferenciacion
    return Usuario.where(:rol_id=>2)
  end
  def usuariosAsistente
    return Usuario.where(:rol_id=>3)
  end
  def usuariosCobranza
    return Usuario.where(:rol_id=>4)
  end


  def getValorCuotaInt pedido_id
		vc=0
		if p.valor_credito!=nil
			vc=p.valor_credito
		end
		ac=0
		if p.abono_inicial!=nil
			ac=p.abono_inicial
		end
		nc=1
		if p.numero_cuotas!=nil
			nc=p.numero_cuotas
		end
    return (vc-ac)/nc
  end

  def getValorCuota pedido_id
    p=Pedido.find_by_id(pedido_id)
		vc=0
		if p.valor_credito!=nil
			vc=p.valor_credito
		end
		ac=0
		if p.abono_inicial!=nil
			ac=p.abono_inicial
		end
		nc=1
		if p.numero_cuotas!=nil
			nc=p.numero_cuotas
		end
    return number_to_currency((vc-ac)/nc, :format => "%n")
  end



  def getSaldoInt (pedido_id, num_cuota)
    pedido=Pedido.find_by_id(pedido_id)
    cuotas=pedido.cuota
    valor_cuota=getValorCuotaInt pedido_id

    credito_actual=pedido.valor_credito-pedido.abono_inicial
    
    i=0
    while i<cuotas.size
      if cuotas[i].estado=="Pagado" && cuotas[i].num_cuota<=num_cuota
        credito_actual-=valor_cuota
      end
      i+=1
    end
    return credito_actual
  end


  def getSaldo (pedido_id, num_cuota)
    pedido=Pedido.find_by_id(pedido_id)
    cuotas=pedido.cuota
    valor_cuota=getValorCuotaInt pedido_id

    credito_actual=pedido.valor_credito-pedido.abono_inicial
    
    i=0
    while i<cuotas.size
      if cuotas[i].estado=="Pagado" && cuotas[i].num_cuota<=num_cuota
        credito_actual-=valor_cuota
      end
      i+=1
    end
    return number_to_currency(credito_actual, :format => "%n")
  end


	def getCantPedidosPorNumCuota num_cuota
		res=0
		Pedido.all.each do |p|
			c=p.cuota.where(:estado=>"Pendiente",:num_cuota=>num_cuota)
			c_ant=p.cuota.where(:estado=>"Pendiente",:num_cuota=>num_cuota-1)
			if(c_ant.count==0 && c.count!=0)
				res+=1
			end
		end
		return res
	end

	def getCantPedidosPorNumCuotaSinAsignar num_cuota
		res=0
		Pedido.all.each do |p|
			c=p.cuota.where(:estado=>"Pendiente",:num_cuota=>num_cuota,:usuario_id=>nil)
			c_ant=p.cuota.where(:estado=>"Pendiente",:num_cuota=>num_cuota-1)
			if(c_ant.count==0 && c.count!=0)
				res+=1
			end
		end
		return res
	end

	def getPedidosAsesor asesor_id
		Pedido.where(:asesor_id=>asesor_id)
	end

	def getTotalVentasCredito asesor_id
		resultado = 0
		pedidos = Pedido.where(:asesor_id=>asesor_id, :tipo_pago=>"Credito")
		pedidos.each do |p|
			if p.valor_credito!=nil
				resultado+=p.valor_credito
			end
		end
		return resultado
	end

	def getTotalVentasContadoAsesor asesor_id
		resultado = 0
		pedidos = Pedido.where(:asesor_id=>asesor_id, :tipo_pago=>"Contado asesor")
		pedidos.each do |p|
			resultado+=p.valor_credito
		end
		return resultado
	end

	def getTotalVentasContadoEmpresa asesor_id
		resultado = 0
		pedidos = Pedido.where(:asesor_id=>asesor_id, :tipo_pago=>"Contado empresa")
		pedidos.each do |p|
			resultado+=p.valor_credito
		end
		return resultado
	end

	def getCuotasPendientes
		if soyCobranza
			return Cuotum.where(:usuario_id=>current_user,:estado=>"Pendiente").count
		end
		return Cuotum.where(:estado=>"Pendiente").count
	end
	def getCuotasPagadas
		if soyCobranza
			return Cuotum.where(:usuario_id=>current_user,:estado=>"Pagado").count
		end
		return Cuotum.where(:estado=>"Pagado").count
	end
	def getCuotasRevisadas
		if soyCobranza
			return Cuotum.where(:usuario_id=>current_user,:revisado=>true).count
		end
		return Cuotum.where(:revisado=>true).count
	end

	def getCantPedidosPendientes
		res=0
		Pedido.all.each do |p|
			c=p.cuota.where(:estado=>"Pendiente")
			if(c.count<0)
				res+=1
			end
			res+=1
		end
		return res
	end

  def getMora fecha_maxima_pago, fecha_cuota_pagada, pedido_mora
		cant_mora = 0.0

	  fecha_iteradora=fecha_maxima_pago

		while true
			if fecha_cuota_pagada>fecha_iteradora
				cant_mora+=1.0
				fecha_iteradora=fecha_iteradora>>1
			else
				break
			end
		end

    return cant_mora*pedido_mora
  end

	def getSaldoPedido pedido
		total_pagos_cuota=0
		pedido.cuota.each do |cuotum|
			cuotum.pago_cuota.each do |pago_cuotum|
				total_pagos_cuota+=pago_cuotum.monto
			end
		end
		return pedido.valor_credito-total_pagos_cuota
	end
end
