class InventarioPredioIngrEgrGanado < ActiveRecord::Base
  belongs_to :inventario_predio_ingr_egr
  belongs_to :ganado
end
