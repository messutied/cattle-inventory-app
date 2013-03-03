class Inventario < ActiveRecord::Base
  has_many :inventario_predios
  has_many :inventario_ganados
end
