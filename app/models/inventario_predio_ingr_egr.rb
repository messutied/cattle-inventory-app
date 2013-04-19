class InventarioPredioIngrEgr < ActiveRecord::Base
  belongs_to :inventario_predio
  belongs_to :movimientos_tipo

  has_many :inventario_predio_ingr_egr_ganados, dependent: :destroy
  
  scope :ingresos, joins(:movimientos_tipo).where("movimientos_tipos.tipo = ?", "i")
  scope :egresos, joins(:movimientos_tipo).where("movimientos_tipos.tipo = ?", "e")
end
