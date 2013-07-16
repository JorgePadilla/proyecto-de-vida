class Inventario < ActiveRecord::Base
  attr_accessible :cantidad, :producto_id
  belongs_to :producto
	has_many :entrada_inventarios

	def nombre
		return producto.nombre# + " (" + cantidad.to_s + ")"
	end
end
