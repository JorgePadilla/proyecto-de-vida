class AddVariosToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :fecha_deposito_abono_inicial, :date
    add_column :pedidos, :numero_deposito_abono_inicial, :string
    add_column :pedidos, :revisado_abono_inicial, :boolean
  end
end
