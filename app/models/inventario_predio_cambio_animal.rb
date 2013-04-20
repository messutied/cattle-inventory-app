class InventarioPredioCambioAnimal < ActiveRecord::Base
  belongs_to :inventario_predio
  has_many :inventario_predio_cambio_animal_ganados
end
