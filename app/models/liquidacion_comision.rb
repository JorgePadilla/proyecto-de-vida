class LiquidacionComision < ActiveRecord::Base
  attr_accessible :empleado_id, :fecha, :monto, :rol, :fecha_inicio, :fecha_final
end
