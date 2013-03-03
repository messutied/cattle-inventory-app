class InventarioPredioIngrEgr < ActiveRecord::Base
  belongs_to :inventario_predio
  has_many :inventario_predio_ingr_egr_ganado
end
