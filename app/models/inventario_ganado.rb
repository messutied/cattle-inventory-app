class InventarioGanado < ActiveRecord::Base
  belongs_to :inventario
  belongs_to :ganados
end
