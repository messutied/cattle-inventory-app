class InventarioPredioCambioAnimal < ActiveRecord::Base
  belongs_to :inventario_predio
  has_many :inventario_predio_cambio_animal_ganados, dependent: :destroy

  scope :descartes, where(tipo: 'descarte')
  scope :cambios_edad, where(tipo: 'c_edad')
end
