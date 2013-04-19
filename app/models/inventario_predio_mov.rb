class InventarioPredioMov < ActiveRecord::Base
  belongs_to :inventario_predio
  has_many :inventario_predio_mov_ganados, dependent: :destroy
  belongs_to :predio_sec, :class_name => "Predio", :foreign_key => "predio_sec_id"

  scope :ingresos, where("tipo = ?", 'ingr')
  scope :egresos, where("tipo = ?", 'egr')
end
