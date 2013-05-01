class InventarioPredioCambioAnimal < ActiveRecord::Base
  belongs_to :inventario_predio
  has_many :inventario_predio_cambio_animal_ganados, dependent: :destroy

  scope :descartes, where(tipo: 'descarte')
  scope :menos_cambio_edad, where("tipo != ?", 'c_edad')
  scope :cambios_edad, where(tipo: 'c_edad')

  def tipo_nombre
    CambioAnimal.tipo_nombre(tipo)
  end
end
