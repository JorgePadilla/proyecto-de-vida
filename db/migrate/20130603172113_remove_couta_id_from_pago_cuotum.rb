class RemoveCoutaIdFromPagoCuotum < ActiveRecord::Migration
  def up
    remove_column :pago_cuota, :cuota_id
      end

  def down
    add_column :pago_cuota, :cuota_id, :integer
  end
end
