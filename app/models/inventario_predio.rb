class InventarioPredio < ActiveRecord::Base
  belongs_to :inventario
  belongs_to :predio

  has_many :inventario_predio_ingr_egrs
  has_many :inventario_predio_movs
  has_many :inventario_predio_ganados

  def self.get_inventario(predio_id, gestion=false)
    inventario = Inventario.get_inventario(gestion)
    inventario_predio = InventarioPredio.find_by_inventario_id_and_predio_id(inventario.id, predio_id)

    if inventario_predio.nil?
      inventario_predio = InventarioPredio.create(predio_id: predio_id, inventario_id: inventario.id)
    end

    return inventario_predio
  end
end
