class InventarioPredio < ActiveRecord::Base
  belongs_to :inventario
  belongs_to :predio

  has_many :inventario_predio_ingr_egrs, dependent: :destroy
  has_many :inventario_predio_movs, dependent: :destroy
  has_many :inventario_predio_cambio_animals, dependent: :destroy
  has_many :inventario_predio_recs, dependent: :destroy
  has_many :inventario_predio_ganados, dependent: :destroy

  after_create :inicializar

  def self.get_inventario(predio_id, gestion=false)
    inventario = Inventario.get_inventario(gestion)
    inventario_predio = InventarioPredio.find_by_inventario_id_and_predio_id(inventario.id, predio_id)

    if inventario_predio.nil?
      inventario_predio = InventarioPredio.create(predio_id: predio_id, inventario_id: inventario.id)
    end

    return inventario_predio
  end

  def tiene_recuentos
    inventario_predio_recs.count > 0
  end

  private

  def inicializar
    ip_calc = InventarioPredioCalculador.new(self)
    ip_calc.calcular_totales()
  end
end
