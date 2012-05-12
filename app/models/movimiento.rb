class Movimiento < ActiveRecord::Base
	has_many :movimiento_ganados, :dependent => :destroy
	has_many :ganados, :through => :movimiento_ganados
	belongs_to :movimientos_tipo
	belongs_to :predio
	belongs_to :predio_sec, :class_name => "Predio", :foreign_key => "predio_sec_id"

	accepts_nested_attributes_for :movimiento_ganados, 
	#:reject_if => lambda { |m| m[:ganado_id].blank? or m[:cant].blank? }, 
	:allow_destroy => true


	validates  :detalle, :movimientos_tipo_id, :presence => true


	def self.cant_ing_egr(predio, rec_info, tipo_ing_egr, ganados, cant_sec=false)
		gestion = Gestion.get_gestion

		fecha_desde = nil

		if rec_info[:mes_actual] != nil
			fecha_desde = rec_info[:mes_actual].fecha
		else
			fecha_desde = rec_info[:mes_anterior].fecha
		end

		conditions_str = "fecha > ? and movimientos_tipos.id = ? and movimientos.predio_id = ? "
		

		if ganados == -1
			conditions_str += " and movimiento_ganados.ganado_id > 2 "
		elsif ganados == -2

		else
			ganados_str = ""

			ganados.each do |g|
				ganados_str += "OR movimiento_ganados.ganado_id = "+g.to_s+" "
			end

			ganados_str = ganados_str[3..-1] # quitamos el OR del comienzo

			if ganados_str != ""
				conditions_str += " and ("+ganados_str+") "
			end
		end

		

		mov = Movimiento.find(
			:all, 
			:select => 'SUM(movimiento_ganados.'+(cant_sec ? 'cant_sec' : 'cant')+') as ing',
			:joins => [:movimiento_ganados, :movimientos_tipo], 
			:group  => 'movimientos.movimientos_tipo_id',
			:conditions => [conditions_str, fecha_desde, tipo_ing_egr, predio]
			)

		return mov.empty? ? 0 : mov.first.ing
	end


	def parse_fecha(anio, mes, dia)
		self.fecha = anio+"-"+mes+"-"+dia
	end

	def day
		return fecha.day
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
end
