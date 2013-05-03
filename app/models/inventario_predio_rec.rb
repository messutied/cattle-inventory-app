class InventarioPredioRec < ActiveRecord::Base
  belongs_to :inventario_predio
  has_many :inventario_predio_rec_ganados, dependent: :destroy
end
