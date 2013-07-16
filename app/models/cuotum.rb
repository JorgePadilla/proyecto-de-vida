class Cuotum < ActiveRecord::Base
  attr_accessible :estado, :liquidado, :fecha, :valor,:valor_credito,:num_deposito,:valor_deposito, :mora, :descuento, :saldo,:revisado,:observaciones,:usuario_id,:num_cuota,:pedido_id,:liquidado
  belongs_to :pedido
  belongs_to :usuario
	has_many :pago_cuota

	def getFechaLimitePago
		return pedido.fecha_inicio_pago.to_time.advance(:months => num_cuota, :days => pedido.dias_mora).to_date
	end
end
