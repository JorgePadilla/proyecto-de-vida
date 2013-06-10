class AddCuotumIdToPagoCuotum < ActiveRecord::Migration
  def change
    add_column :pago_cuota, :cuotum_id, :integer
  end
end
