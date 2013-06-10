class PagoCuotum < ActiveRecord::Base
  attr_accessible :cuotum_id, :fecha, :monto, :numero_deposito, :revisado
	belongs_to :cuotum
end
