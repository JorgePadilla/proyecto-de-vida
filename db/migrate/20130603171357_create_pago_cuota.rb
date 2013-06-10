class CreatePagoCuota < ActiveRecord::Migration
  def change
    create_table :pago_cuota do |t|
      t.integer :cuota_id
      t.date :fecha
      t.string :numero_deposito
      t.decimal :monto
      t.boolean :revisado

      t.timestamps
    end
  end
end
