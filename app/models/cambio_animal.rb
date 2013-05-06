class CambioAnimal < ActiveRecord::Base
  has_many :cambio_animal_ganados, dependent: :destroy
  belongs_to :empleado
  belongs_to :gestion
  belongs_to :predio

  accepts_nested_attributes_for :cambio_animal_ganados

  after_save :update_inventario
  after_destroy :update_inventario
  before_validation :set_gestion

  scope :descartes, where(tipo: 'descarte')
  scope :menos_cambio_edad, where("tipo != ?", 'c_edad')
  scope :cambios_edad, where(tipo: 'c_edad')

  validates :tipo, :gestion_id, :fecha, presence: true

  def self.tipo_nombre(tipo)
    nombres = {'descarte' => 'Descarte', 'c_edad' => 'Cambio Edad'}
    nombres[tipo]
  end

  def parse_fecha!(dia)
    if new_record?
      gestion = Gestion.gestion_abierta
      self.fecha = "#{gestion.anio}-#{gestion.mes}-#{dia}"
    else
      self.fecha.change(day: dia)
    end
  end

  private

  def update_inventario
    inv_predio = InventarioPredio.get_inventario(predio_id)
    ip_calc = InventarioPredioCalculador.new(inv_predio)

    inv = Inventario.get_inventario
    inv_calc = InventarioCalculador.new(inv)

    if tipo == "descarte"
      ip_calc.calcular_cambio_animal
      ip_calc.calcular_totales
    else
      inv_calc.calcular_cambio_edades
      inv_calc.calcular_totales
    end

    inv_calc.calcular_inventario_ganados_totales()
  end

  def set_gestion
    self.gestion = Gestion.gestion_abierta
  end
end
