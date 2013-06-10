class RepartirController < ApplicationController

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

	def initIndex pedidos
		@cuota_pendiente=[]
		@cuota_pendiente[1]=-1
		@cuota_pendiente[2]=-2
		@cuota_pendiente[3]=-3
		@cuota_pendiente[4]=-4
		@cuota_pendiente[5]=-5
		@cuota_pendiente[6]=-6

		num_cuota=1

		while num_cuota<=6
			res=0
			pedidos.each do |p|
				c=p.cuota.where(:estado=>"Pendiente",:num_cuota=>num_cuota,:usuario_id=>nil)
				c_ant=p.cuota.where(:estado=>"Pendiente",:num_cuota=>num_cuota-1)
				if(c_ant.count==0 && c.count!=0)
					res+=1
				end
			end
			@cuota_pendiente[num_cuota]=res
			num_cuota+=1
		end
	end

  def index
		$pedidos=Pedido.all
		initIndex $pedidos
  end

	def buscar_cuotas

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

		@string_fecha_inicio = anio_inicio + "-" + mes_inicio + "-" + dia_inicio
		@string_fecha_final = anio_final + "-" + mes_final + "-" + dia_final

    str = " fecha_inicio_pago BETWEEN '" + @string_fecha_inicio + "' and '" + @string_fecha_final + "'"

    $pedidos = Pedido.where(str)

		initIndex $pedidos

    render :index
	end

	def cuotas_repartidas
		
	end

	def asignarCuotas num_cuota, cantidad, gestor_de_cobro
		cant=0
		$pedidos.each do |p|
			c=p.cuota.where(:estado=>"Pendiente",:num_cuota=>num_cuota,:usuario_id=>nil)
			c_ant=p.cuota.where(:estado=>"Pendiente",:num_cuota=>num_cuota-1)
			if(c_ant.count==0 && c.count!=0)
				cant+=1
				if cant>cantidad
					break
				end
				couta_temp=c[0]
				couta_temp.usuario_id=gestor_de_cobro
				couta_temp.save
				$cuotas_asignadas.push(couta_temp)
			end
		end
	end

  def reparticion
    gestor_de_cobro=Integer(params[:gestor_de_cobro][0])
	  cant_cuota_1=Integer(params[:cuota_1])
    cant_cuota_2=Integer(params[:cuota_2])
    cant_cuota_3=Integer(params[:cuota_3])
    cant_cuota_4=Integer(params[:cuota_4])
    cant_cuota_5=Integer(params[:cuota_5])
    cant_cuota_6=Integer(params[:cuota_6])

		$gestor_de_cobro=Usuario.find_by_id(gestor_de_cobro)

		$cuotas_asignadas=[]

		asignarCuotas 1, cant_cuota_1, gestor_de_cobro
		asignarCuotas 2, cant_cuota_2, gestor_de_cobro
		asignarCuotas 3, cant_cuota_3, gestor_de_cobro
		asignarCuotas 4, cant_cuota_4, gestor_de_cobro
		asignarCuotas 5, cant_cuota_5, gestor_de_cobro
		asignarCuotas 6, cant_cuota_6, gestor_de_cobro

    render :coutas_repartidas
  end
end
