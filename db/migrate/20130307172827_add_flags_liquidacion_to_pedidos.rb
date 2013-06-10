class AddFlagsLiquidacionToPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :liquidado_asesor, :boolean
    add_column :pedidos, :liquidado_moderador, :boolean
    add_column :pedidos, :liquidado_coordinador, :boolean
    add_column :pedidos, :liquidado_director_comercial, :boolean
    add_column :pedidos, :liquidado_gerente_comercial, :boolean
  end
end
