class InventarioPredioMov < ActiveRecord::Base
  belongs_to :inventario_predio
  has_many :inventario_predio_mov_ganado
end
