class CreateLiquidacionComisions < ActiveRecord::Migration
  def change
    create_table :liquidacion_comisions do |t|
      t.integer :empleado_id
      t.string :rol
      t.date :fecha
      t.integer :monto

      t.timestamps
    end
  end
end
