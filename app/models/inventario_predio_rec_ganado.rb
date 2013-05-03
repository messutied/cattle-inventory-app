class InventarioPredioRecGanado < ActiveRecord::Base
  belongs_to :inventario_predio_rec
  belongs_to :ganado
end
