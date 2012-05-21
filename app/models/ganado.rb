class Ganado < ActiveRecord::Base
  belongs_to :ganado_grupo
  has_many :movimiento_ganados
  has_many :movimientos, :through => :movimiento_ganados

  scope :un_mes, lambda {where("id=1 or id=2")}

  def self.recuento_info(predio)
    gestion = Gestion.get_gestion

    rec_mes_actual = nil
    rec_mes_anterior = nil

    # Revisar recuentos en el mes
    mov = Movimiento.find( 
      :all, 
      :joins => :ganados, 
      :conditions => ["fecha >= ? and fecha < ? and movimientos_tipo_id=9 and predio_id = ?", 
      gestion[:desde], gestion[:hasta], predio],
      :order => "fecha desc",
      :limit => 1
      )

    if mov.any?
      rec_mes_actual = mov.first
    end

    # obtener el ultimo recuento anterior a gestion
    mov = Movimiento.find(
      :all, 
      :joins => :ganados, 
      :conditions => ["fecha < ? and movimientos_tipo_id=9 and predio_id = ?", gestion[:desde], predio],
      :order => "fecha desc",
      :limit => 1
      )

    if mov.any?
      rec_mes_anterior = mov.first
    end

    return {:mes_actual => rec_mes_actual, :mes_anterior => rec_mes_anterior}
  end

  def cant_ing_egr(predio, rec_info, tipo_ing_egr, cant_sec=false)
    fecha_desde = nil

    if rec_info[:mes_actual] != nil
      fecha_desde = rec_info[:mes_actual].fecha
    else
      fecha_desde = rec_info[:mes_anterior].fecha
    end

    mov = Movimiento.find(
      :all, 
      :select     => 'SUM(movimiento_ganados.'+(cant_sec ? 'cant_sec' : 'cant')+') as ing',
      :joins      => [:movimiento_ganados, :movimientos_tipo], 
      :group      => 'movimiento_ganados.ganado_id',
      :conditions => ["fecha > ? and movimientos_tipos.id = ? and movimientos.predio_id = ? "+
        "and movimiento_ganados.ganado_id = ?", fecha_desde, tipo_ing_egr, predio, self.id]
      )

    return mov.empty? ? 0 : mov.first.ing
  end

  def sumatoria_ingr_egr(tipo, predio, fecha_desde=nil, fecha_hasta=nil, ganados=nil)
    conditions_str = "movimientos_tipos.tipo='"+tipo+"' and movimientos.predio_id = "+predio.to_s

    if ganados == nil
      conditions_str += " and movimiento_ganados.ganado_id = "+self.id.to_s
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
      :select     => 'SUM(movimiento_ganados.cant) as sumatoria',
      :joins      => [:movimiento_ganados, :movimientos_tipo], 
      :group      => ganados == nil ? 'movimiento_ganados.ganado_id' : 'movimientos.movimientos_tipo_id',
      :conditions => conditions_arr
      )

    if mov.any?
      return mov.first.sumatoria
    end
    return 0
  end

  def sumatoria_mov(tipo, predio, fecha_desde=nil, fecha_hasta=nil)
    conditions_str = "movimientos_tipos.tipo='m' and movimientos.predio"+(tipo == "i" ? '_sec' : '')+"_id = "+
      predio.to_s+" and movimiento_ganados.ganado_id = ?"

    if fecha_desde != nil
      conditions_str += " and fecha > ?"
    end

    if fecha_hasta != nil
      conditions_str += " and fecha < ?"
    end

    conditions_arr = [conditions_str, self.id]

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
      :group  => 'movimiento_ganados.ganado_id',
      :conditions => conditions_arr
      )

    if mov.any?
      return mov.first.sumatoria
    end
    return 0
  end

  def cant_inicial(predio, rec_info)
  	# Revisar recuentos en el mes
    if rec_info[:mes_actual] == nil # si no hubo recuentos en el mes

      # obtener el ultimo recuento anterior a gestion

      if rec_info[:mes_anterior] != nil # si hay recuentos
        mov = rec_info[:mes_anterior]

        rec_mov       = mov
        rec_cant      = rec_mov.movimiento_ganados.where("ganado_id = ?", self.id).first.cant
        ingresos      = 0
        egresos       = 0
        mov_salidas   = 0
        mov_entradas  = 0

        # sumatoria de los ingresos
        ingresos = sumatoria_ingr_egr("i", predio, nil, rec_mov.fecha)

        # sumatoria de los egresos
        egresos = sumatoria_ingr_egr("e", predio, nil, rec_mov.fecha)

        # sumatoria de movimientos salidas
        mov_salidas = sumatoria_mov('e', predio, nil, rec_mov.fecha)

        # sumatoria de movimientos entradas
        mov_salidas = sumatoria_mov('i', predio, nil, rec_mov.fecha)

        return rec_cant + ingresos + mov_entradas - egresos - mov_salidas

      else
        return 0 # no existe ningun recuento (Inicial)
      end
    else
      # Hubo un recuento este mes, se devuelve su resultado
      mov = rec_info[:mes_actual]
      return mov.movimiento_ganados.where("ganado_id = ?", self.id).first.cant
    end
  end

  def saldo_parcial_ingresos(predio, rec_info)
    rec = rec_info[:mes_anterior]

    if rec_info[:mes_actual] != nil
      rec = rec_info[:mes_actual]
    end
    # sumatoria de los ingresos
    ingresos = sumatoria_ingr_egr("i", predio, rec.fecha, nil)

    mov_ingresos = sumatoria_mov('i', predio, rec.fecha, nil)

    return ingresos + mov_ingresos + rec.movimiento_ganados.where("ganado_id = ?", self.id).first.cant
  end

  def saldo_mes(predio, rec_info)
    rec = rec_info[:mes_anterior]

    if rec_info[:mes_actual] != nil
      rec = rec_info[:mes_actual]
    end
    # sumatoria de los ingresos
    ingresos = sumatoria_ingr_egr("i", predio, rec.fecha, nil)

    mov_ingresos = sumatoria_mov('i', predio, rec.fecha, nil)

    # sumatoria de los egresos
    egresos = sumatoria_ingr_egr("e", predio, rec.fecha, nil)

    mov_egresos = sumatoria_mov('e', predio, rec.fecha, nil)

    return ingresos + mov_ingresos + rec.movimiento_ganados.where("ganado_id = ?", self.id).first.cant - egresos - mov_egresos
  end
end
