class InventarioPredioIngrEgr < ActiveRecord::Base
  belongs_to :inventario_predio
  belongs_to :movimientos_tipo

  has_many :inventario_predio_ingr_egr_ganados
end
