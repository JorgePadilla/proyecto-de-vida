class Cuotum < ActiveRecord::Base
  attr_accessible :estado, :liquidado, :fecha, :valor,:valor_credito,:num_deposito,:valor_deposito, :mora, :descuento, :saldo,:revisado,:observaciones,:usuario_id,:num_cuota,:pedido_id,:liquidado
  belongs_to :pedido
  belongs_to :usuario
	has_many :pago_cuota
end
