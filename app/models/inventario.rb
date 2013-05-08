class Inventario < ActiveRecord::Base
  has_many :inventario_predios, dependent: :destroy
  has_many :inventario_ganados
  belongs_to :gestion

  after_create :inicializar

  def self.get_inventario(gestion=false)
    gestion ||= Gestion.gestion_abierta
    gestion.get_inventario
  end

  def get_inventario_predio(predio_id)
    inventario_predio = InventarioPredio.find_by_inventario_id_and_predio_id(id, predio_id)

    if inventario_predio.nil?
      inventario_predio = InventarioPredio.create(predio_id: predio_id, inventario_id: id)
    end

    return inventario_predio
  end

  private

  def inicializar
    inv_calc = InventarioCalculador.new(self)
    inv_calc.calcular_inventario_ganados_totales()
  end
end
