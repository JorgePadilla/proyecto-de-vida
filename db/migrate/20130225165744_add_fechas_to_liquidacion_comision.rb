class AddFechasToLiquidacionComision < ActiveRecord::Migration
  def change
    add_column :liquidacion_comisions, :fecha_inicio, :date
    add_column :liquidacion_comisions, :fecha_final, :date
  end
end
