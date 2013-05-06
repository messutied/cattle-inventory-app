class Movimiento < ActiveRecord::Base
	has_many :movimiento_ganados, :dependent => :destroy
  has_many :ganados, :through => :movimiento_ganados, :uniq => true
	has_many :ganado_grupos, :through => :ganados
	belongs_to :movimientos_tipo
	belongs_to :predio
	belongs_to :predio_sec, :class_name => "Predio", :foreign_key => "predio_sec_id"
  belongs_to :empleado
  belongs_to :gestion

	accepts_nested_attributes_for :movimiento_ganados, allow_destroy: true


	validates :detalle, :movimientos_tipo_id, :fecha, :predio_id, 
            :gestion_id, :empleado_id, presence: true

  after_save :update_inventario
  after_destroy :update_inventario
  before_validation :set_gestion

  scope :movimientos, joins(:movimientos_tipo).where("movimientos_tipos.tipo = ?", 'm')
  scope :recuentos, joins(:movimientos_tipo).where("movimientos_tipos.tipo = ?", 'r')
  scope :movimientos_perdidas, where("movimientos_tipos.tipo='m' and "+
        "movimiento_ganados.cant>movimiento_ganados.cant_sec")
        .joins(:movimientos_tipo, :movimiento_ganados)
  
  scope :movimientos_incompletos, where("movimiento_ganados.cant_sec is null")
        .joins(:ganado_grupos, :predio, :predio_sec)
        .select("movimientos.id, movimientos.fecha, movimientos.detalle, "+
          "movimiento_ganados.cant as cantidad, ganado_grupos.nombre as ganado_grupo_nombre, ganados.nombre as ganado_nombre, "+
          "predios.nombre as predio_nombre, predio_secs_movimientos.nombre as predio_sec_nombre")

	def parse_fecha!(dia)
    if new_record?
      gestion = Gestion.gestion_abierta
      self.fecha = "#{gestion.anio}-#{gestion.mes}-#{dia}"
    else
      self.fecha.change(day: dia.to_i)
    end
  end

	def day
		return fecha.day
	end

  def mes
    return self.fecha.month
  end

  def year
    return self.fecha.year
  end

	def mov_tipo
		self.movimientos_tipo.tipo
	end

	def type_str
		if ["i", "e"].include? self.movimientos_tipo.tipo
			return "in_eg"
		elsif ["m"].include? self.movimientos_tipo.tipo
			return "mov"
		else
			return "rec"
		end
	end

	def self.type_name(type)
		if type == "mov"
			return "Movimientos"
		elsif type == "in_eg"
			return "Ingresos/Egresos"
		else
			return "Recuentos"
		end
	end

  private

  def update_inventario
    inv_predio = InventarioPredio.get_inventario(predio_id)
    ip_calc = InventarioPredioCalculador.new(inv_predio)

    inv = Inventario.get_inventario
    inv_calc = InventarioCalculador.new(inv)

    if ['i', 'e', 'r'].include? movimientos_tipo.tipo
      ip_calc.calcular_ingr_egr_ganado_predio
    end

    if ['m', 'r'].include? movimientos_tipo.tipo
      ip_calc.calcular_mov_ganado
    end

    if ['r'].include? movimientos_tipo.tipo
      ip_calc.calcular_rec_ganado
    end

    ip_calc.calcular_totales
    inv_calc.calcular_inventario_ganados_totales()
  end

  def set_gestion
    self.gestion = Gestion.gestion_abierta
  end
end
