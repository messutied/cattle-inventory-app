class InventarioPredioMovGanado < ActiveRecord::Base
  belongs_to :inventario_predio_mov
  belongs_to :ganado
end
