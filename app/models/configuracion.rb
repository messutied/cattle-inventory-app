class Configuracion < ActiveRecord::Base
  has_many :configuracion_cambio_animals, dependent: :destroy
  has_many :configuracion_cambio_edads, dependent: :destroy
  has_many :configuracion_descartes, dependent: :destroy

  accepts_nested_attributes_for :configuracion_cambio_animals, allow_destroy: true,
    reject_if: ->(ca) { ca[:ganado_desde].blank? or ca[:ganado_hasta].blank? }

  accepts_nested_attributes_for :configuracion_cambio_edads, allow_destroy: true,
    reject_if: ->(ca) { ca[:ganado_desde].blank? or ca[:ganado_hasta].blank? }
    
  accepts_nested_attributes_for :configuracion_descartes, allow_destroy: true,
    reject_if: ->(ca) { ca[:ganado_desde].blank? or ca[:ganado_hasta].blank? }
end
