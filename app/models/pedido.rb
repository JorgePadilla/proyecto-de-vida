class Pedido < ActiveRecord::Base
  attr_accessible :telefono_conyugue,:referencia2,:telefono_referencia2,:descuento,:mora,:numero_pedido,:abono_inicial, :alumno, :asesor_id, :cargo_cliente, :celular_cliente, :ciudad, :ciudad_cliente, :conyugue, :correo_electronico, :departamento_cliente, :direccion_cliente, :evento, :fecha_ingreso, :fecha_inicio_pago, :fecha_evento, :fin_hora_contacto, :grado, :identidad_cliente, :inicio_hora_contacto, :jornada, :nombre_cliente, :numero_cuotas, :referencia, :telefono_cliente, :telefono_referencia, :telefono_trabajo, :trabajo_cliente, :valor_credito, :valor_cuota,
:tipo_pago,:fecha_ingreso, :num_dias_descuento,:rvi,:dias_mora,:estado_pedido,:observaciones, :liquidado_asesor, :liquidado_moderador, :liquidado_coordinador, :liquidado_director_comercial, :liquidado_gerente_comercial,:fecha_deposito_abono_inicial,:numero_deposito_abono_inicial,:revisado_abono_inicial

	belongs_to :asesor
  has_many :producto_pedidos
  has_many :cuota
end
