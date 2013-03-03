class InventarioPredio < ActiveRecord::Base
  belongs_to :inventario

  has_many :inventario_predio_ingr_egr
  has_many :inventario_predio_mov
  has_many :inventario_predio_ganado
end
