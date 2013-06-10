class Asesor < ActiveRecord::Base

  has_many :transitos
 attr_accessible :comision_contado_asesor, :comision_contado_empresa, :comision_credito, :identidad, :moderador_id, :nombre
  belongs_to :moderador
end
