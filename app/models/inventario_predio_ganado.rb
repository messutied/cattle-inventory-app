class InventarioPredioGanado < ActiveRecord::Base
  belongs_to :inventario_predio
  belongs_to :ganado
end
