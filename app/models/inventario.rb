class Inventario < ActiveRecord::Base
  has_many :inventario_predios
  has_many :inventario_ganados
  belongs_to :gestion

  def self.get_inventario
    # puts Gestion.gestion_abierta.to_json
    Gestion.gestion_abierta.get_inventario
  end

  def get_inventario_predio(predio_id)
    inventario_predio = InventarioPredio.find_by_inventario_id_and_predio_id(id, predio_id)

    if inventario_predio.nil?
      inventario_predio = InventarioPredio.create(predio_id: predio_id, inventario_id: id)
    end

    return inventario_predio
  end
end
