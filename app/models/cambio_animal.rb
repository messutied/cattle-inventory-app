class CambioAnimal < ActiveRecord::Base
  has_many :cambio_animal_ganados, dependent: :destroy
  belongs_to :empleado
  belongs_to :gestion
  belongs_to :predio

  accepts_nested_attributes_for :cambio_animal_ganados

  after_save :update_inventario
  after_destroy :update_inventario
  before_save :set_gestion

  private

  def update_inventario
    inv_predio = InventarioPredio.get_inventario(predio_id)
    inv_calc = InventarioPredioCalculador.new(inv_predio)

    inv_calc.calculate_cambio_animal
    inv_calc.calculate_totals
  end

  def set_gestion
    self.gestion = Gestion.gestion_abierta
  end

  def parse_fecha!(dia)
    gestion = Gestion.gestion_abierta
    self.fecha = "#{gestion.anio}-#{gestion.mes}-#{dia}"
  end
end
