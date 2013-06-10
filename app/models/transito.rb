class Transito < ActiveRecord::Base
  attr_accessible :asesor_id, :cantidad, :inventario_id
  belongs_to :asesor
  belongs_to :inventario
	has_many :nota_entregas
	has_many :nota_devolucions

	def nombre
		if inventario == nil
			return "Error! No existe el producto en inventario."
		end
		return asesor.nombre + "-" + inventario.nombre# + " (" + cantidad.to_s + ")"
	end
end
