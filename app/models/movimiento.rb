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
		elsif ganados != - 2
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

	def total_por_ganado(ganado, cant_sec=false)
		if ganado.class == String or ganado.class == Fixnum
			if self.movimiento_ganados.where("ganado_id=?", ganado).any?
				if cant_sec
					return self.movimiento_ganados.where("ganado_id=?", ganado).first.cant_sec
				else
					return self.movimiento_ganados.where("ganado_id=?", ganado).first.cant
				end
			end

			return 0
		else
			conditions_str = ""
			ganado_str = ""

			if ganado == -1
				conditions_str += "ganado_id > 2 "
			elsif ganado != - 2
				ganado.each do |g|
					ganado_str += ","+g.to_s
				end

				ganado_str = ganado_str[1..-1] # strip first comma
				conditions_str = "ganado_id in ("+ganado_str+")"
			end

			

			total = self.movimiento_ganados.find(
				:all, 
				:select => "sum(cant"+(cant_sec ? "_sec" : "")+") as total", 
				:group => "movimiento_ganados.id",
				:conditions => conditions_str
			)

			return total.any? ? total.first.total : 0
		end
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
