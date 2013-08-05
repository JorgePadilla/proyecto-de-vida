class Inventario < ActiveRecord::Base
  attr_accessible :cantidad, :producto_id
  belongs_to :producto
	has_many :entrada_inventarios

	def nombre
		if producto==nil
			return "Error: no existe el producto."
		end
		return producto.nombre# + " (" + cantidad.to_s + ")"
	end
end
