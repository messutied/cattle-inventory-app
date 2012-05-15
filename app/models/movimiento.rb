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

	def self.sumatoria_ingr_egr(tipo, predio, ganados, fecha_desde=nil, fecha_hasta=nil)
    conditions_str = "movimientos_tipos.tipo='"+tipo+"' and movimientos.predio_id = "+predio.to_s

    if ganados.class == Fixnum
    	if ganados == -1
				conditions_str += " and movimiento_ganados.ganado_id > 2 "
			elsif ganados != -2
      	conditions_str += " and movimiento_ganados.ganado_id = "+ganados.to_s
      else
				# debugger
      end
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

    if fecha_desde != nil
      conditions_str += " and fecha > ?"
    end

    if fecha_hasta != nil
      conditions_str += " and fecha < ?"
    end

    conditions_arr = [conditions_str]

    if fecha_desde != nil
      conditions_arr.push(fecha_desde)
    end

    if fecha_hasta != nil
      conditions_arr.push(fecha_hasta)
    end

    mov = Movimiento.find(
      :all, 
      :select => 'SUM(movimiento_ganados.cant) as sumatoria',
      :joins => [:movimiento_ganados, :movimientos_tipo], 
      # :group  => (ganados.class == Fixnum and ganados > 0) ? 'movimiento_ganados.ganado_id' : 'movimientos.movimientos_tipo_id',
      :conditions => conditions_arr
      )

    if mov.any?
      return mov.first.sumatoria == nil ? 0 : mov.first.sumatoria
    end
    return 0
  end

	def self.sumatoria_mov(tipo, predio, ganados, fecha_desde=nil, fecha_hasta=nil)
    conditions_str = "movimientos_tipos.tipo='m' and movimientos.predio"+(tipo == "i" ? '_sec' : '')+"_id = "+predio.to_s

    if ganados.class == Fixnum
    	if ganados == -1
				conditions_str += " and movimiento_ganados.ganado_id > 2 "
			elsif ganados != -2
      	conditions_str += " and movimiento_ganados.ganado_id = "+ganados.to_s
      end
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

    if fecha_desde != nil
      conditions_str += " and fecha > ?"
    end

    if fecha_hasta != nil
      conditions_str += " and fecha < ?"
    end

    conditions_arr = [conditions_str]

    if fecha_desde != nil
      conditions_arr.push(fecha_desde)
    end

    if fecha_hasta != nil
      conditions_arr.push(fecha_hasta)
    end
    
    mov = Movimiento.find(
      :all, 
      :select => 'SUM(movimiento_ganados.cant'+(tipo == "i" ? '_sec' : '')+') as sumatoria',
      :joins => [:movimiento_ganados, :movimientos_tipo], 
      :group  => (ganados.class == Fixnum and ganados > 0) ? 'movimiento_ganados.ganado_id' : 'movimientos.movimientos_tipo_id',
      :conditions => conditions_arr
      )

    if mov.any?
      return mov.first.sumatoria
    end
    return 0
  end

  def self.cant_inicial(predio, rec_info, ganado)
  	# Revisar recuentos en el mes
    if rec_info[:mes_actual] == nil # si no hubo recuentos en el mes

      # obtener el ultimo recuento anterior a gestion

      if rec_info[:mes_anterior] != nil # si hay recuentos
        mov = rec_info[:mes_anterior]

        conditions_str = ""

        if ganado.class == Fixnum
		    	if ganado == -1
						conditions_str += "ganado_id > 2 "
					elsif ganado != - 2
		      	conditions_str += " ganado_id = "+ganado.to_s
		      end
		    else
		      ganados_str = ""

		      ganado.each do |g|
		        ganados_str += "OR ganado_id = "+g.to_s+" "
		      end

		      ganados_str = ganados_str[3..-1] # quitamos el OR del comienzo

		      if ganados_str != ""
		        conditions_str += "("+ganados_str+") "
		      end
		    end

		    print("*********** "+conditions_str)

        rec_mov       = mov
        # rec_cant      = rec_mov.movimiento_ganados.where(conditions_str).first.cant
        rec_cant = rec_mov.movimiento_ganados.find(
        	:all, 
		      :select => 'SUM(movimiento_ganados.cant) as total',
		      :joins => [:movimiento], 
		      :group  => (ganado.class == Fixnum and ganado > 0) ? 'movimiento_ganados.ganado_id' : 'movimientos.movimientos_tipo_id',
		      :conditions => [conditions_str]
	      )

	      rec_cant = rec_cant.any? ? rec_cant.first.total : 0

        ingresos      = 0
        egresos       = 0
        mov_salidas   = 0
        mov_entradas  = 0

        # sumatoria de los ingresos
        ingresos = Movimiento.sumatoria_ingr_egr("i", predio, ganado, nil, rec_mov.fecha)

        # sumatoria de los egresos
        egresos = Movimiento.sumatoria_ingr_egr("e", predio, ganado, nil, rec_mov.fecha)

        # sumatoria de movimientos salidas
        mov_salidas = Movimiento.sumatoria_mov('e', predio, ganado, nil, rec_mov.fecha)

        # sumatoria de movimientos entradas
        mov_salidas = Movimiento.sumatoria_mov('i', predio, ganado, nil, rec_mov.fecha)

        return rec_cant + ingresos + mov_entradas - egresos - mov_salidas

      else
        return 0 # no existe ningun recuento (Inicial)
      end
    else
      # Hubo un recuento este mes, se devuelve su resultado
      mov = rec_info[:mes_actual]
      return mov.movimiento_ganados.where(conditions_str).first.cant
    end
  end

  def self.saldo_mes(predio, rec_info, ganado)
    rec = rec_info[:mes_anterior]

    if rec_info[:mes_actual] != nil
      rec = rec_info[:mes_actual]
    end

    conditions_str = ""

    if ganado.class == Fixnum
    	if ganado == -1
				conditions_str += "ganado_id > 2 "
			elsif ganado != -2
      	conditions_str += " ganado_id = "+ganado.to_s
      end
    else
      ganados_str = ""

      ganado.each do |g|
        ganados_str += "OR ganado_id = "+g.to_s+" "
      end

      ganados_str = ganados_str[3..-1] # quitamos el OR del comienzo

      if ganados_str != ""
        conditions_str += "("+ganados_str+") "
      end
    end

    # sumatoria de los ingresos
    # debugger
    ingresos = Movimiento.sumatoria_ingr_egr("i", predio, ganado, rec.fecha, nil)

    mov_ingresos = Movimiento.sumatoria_mov('i', predio, ganado, rec.fecha, nil)

    # sumatoria de los egresos
    egresos = Movimiento.sumatoria_ingr_egr("e", predio, ganado, rec.fecha, nil)

    mov_egresos = Movimiento.sumatoria_mov('e', predio, ganado, rec.fecha, nil)

    rec_cant = rec.movimiento_ganados.find(
    	:all, 
      :select => 'SUM(movimiento_ganados.cant) as total',
      :joins => [:movimiento], 
      :group  => (ganado.class == Fixnum and ganado > 0) ? 'movimiento_ganados.ganado_id' : 'movimientos.movimientos_tipo_id',
      :conditions => [conditions_str]
    )

    rec_cant = rec_cant.any? ? rec_cant.first.total : 0
    # rec_cant = rec.movimiento_ganados.where("ganado_id = ?", self.id).first.cant

    # return " " + ingresos.to_s + ", " + mov_ingresos.to_s + ", " + rec_cant.to_s + ", " + egresos.to_s + ", " + mov_egresos.to_s
    return ingresos + mov_ingresos + rec_cant - egresos - mov_egresos
  end

  def self.saldo_parcial_ingresos(predio, rec_info, ganado)

  	conditions_str = ""

    if ganado.class == Fixnum
    	if ganado == -1
				conditions_str += "ganado_id > 2 "
			elsif ganado != -2
      	conditions_str += " ganado_id = "+ganado.to_s
      end
    else
      ganados_str = ""

      ganado.each do |g|
        ganados_str += "OR ganado_id = "+g.to_s+" "
      end

      ganados_str = ganados_str[3..-1] # quitamos el OR del comienzo

      if ganados_str != ""
        conditions_str += "("+ganados_str+") "
      end
    end


    rec = rec_info[:mes_anterior]

    if rec_info[:mes_actual] != nil
      rec = rec_info[:mes_actual]
    end
    # sumatoria de los ingresos
    ingresos = Movimiento.sumatoria_ingr_egr("i", predio, ganado, rec.fecha, nil)

    mov_ingresos = Movimiento.sumatoria_mov('i', predio, ganado, rec.fecha, nil)

    rec_cant = rec.movimiento_ganados.find(
    	:all, 
      :select => 'SUM(movimiento_ganados.cant) as total',
      :joins => [:movimiento], 
      :group  => (ganado.class == Fixnum and ganado > 0) ? 'movimiento_ganados.ganado_id' : 'movimientos.movimientos_tipo_id',
      :conditions => [conditions_str]
    )

    rec_cant = rec_cant.any? ? rec_cant.first.total : 0

    return ingresos.to_i + mov_ingresos.to_i + rec_cant.to_i
  end

	def self.cant_ing_egr(predio, rec_info, tipo_ing_egr, ganados, cant_sec=false)
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
