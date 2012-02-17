class Movimiento < ActiveRecord::Base
	has_many :movimiento_ganados, :dependent => :destroy
	belongs_to :movimientos_tipo
	belongs_to :predio
	belongs_to :predio_sec, :class_name => "Predio", :foreign_key => "predio_sec_id"

	accepts_nested_attributes_for :movimiento_ganados, 
	:reject_if => lambda { |m| m[:ganado_id].blank? or m[:cant].blank? }, 
	:allow_destroy => true


	validates  :detalle, :movimientos_tipo_id, :presence => true

	def parse_fecha(anio, mes, dia)
		self.fecha = anio+"-"+mes+"-"+dia
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
end
