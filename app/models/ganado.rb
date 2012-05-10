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
      rec_mes_actual = mov.first.id
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
      rec_mes_anterior = mov.first.id
    end

    return {:mes_actual => rec_mes_actual, :mes_anterior => rec_mes_anterior}
  end

  def cant_ing_egr(predio, tipo_ing_egr)
    gestion = Gestion.get_gestion

    mov = Movimiento.find(
      :all, 
      :select => 'SUM(movimiento_ganados.cant) as ing',
      :joins => [:movimiento_ganados, :movimientos_tipo], 
      :group  => 'movimiento_ganados.ganado_id',
      :conditions => ["fecha > ? and movimientos_tipos.id = ? and movimientos.predio_id = ? "+
        "and movimiento_ganados.ganado_id = ?", rec_mov.fecha, predio, tipo_ing_egr, self.id]
      )
  end

  def cant_inicial(predio, rec_info)
  	gestion_anio = Time.now.year
  	gestion_mes = Time.now.month

  	gesion_desde = gestion_anio.to_s+"-"+("%02d" % gestion_mes).to_s+"-01"

  	if gestion_mes <= 11
  		gesion_hasta = gestion_anio.to_s+"-"+("%02d" % (gestion_mes+1)).to_s+"-01"
  	else
  		gesion_hasta = (gestion_anio+1).to_s+"-01-01" # si es diciembre, pasar a enero
  	end


  	# Revisar recuentos en el mes
    if rec_info[:mes_actual] == nil # si no hubo recuentos en el mes

      # obtener el ultimo recuento anterior a gestion
      mov = Movimiento.find(
        :all, 
        :joins => :ganados, 
        :conditions => ["fecha < ? and movimientos_tipo_id=9 and predio_id = ?", gesion_desde, predio],
        :order => "fecha desc",
        :limit => 1
        )

      if mov.any? # si hay recuentos
        rec_mov = mov.first
        rec_cant = rec_mov.movimiento_ganados.where("ganado_id = ?", self.id).first.cant
        ingresos = 0
        egresos = 0
        mov_salidas = 0
        mov_entradas = 0

        # sumatoria de los ingresos
        mov = Movimiento.find(
          :all, 
          :select => 'SUM(movimiento_ganados.cant) as ing',
          :joins => [:movimiento_ganados, :movimientos_tipo], 
          :group  => 'movimiento_ganados.ganado_id',
          :conditions => ["fecha > ? and movimientos_tipos.tipo='i' and movimientos.predio_id = ? "+
            "and movimiento_ganados.ganado_id = ?", rec_mov.fecha, predio, self.id]
          )

        if mov.any?
          ingresos = mov.first.ing
        end

        # sumatoria de los egresos
        mov = Movimiento.find(
          :all, 
          :select => 'SUM(movimiento_ganados.cant) as ing',
          :joins => [:movimiento_ganados, :movimientos_tipo], 
          :group  => 'movimiento_ganados.ganado_id',
          :conditions => ["fecha > ? and movimientos_tipos.tipo='e' and movimientos.predio_id = ? "+
            "and movimiento_ganados.ganado_id = ?", rec_mov.fecha, predio, self.id]
          )

        if mov.any?
          egresos = mov.first.ing
        end

        # sumatoria de movimientos salidas
        mov = Movimiento.find(
          :all, 
          :select => 'SUM(movimiento_ganados.cant) as ing',
          :joins => [:movimiento_ganados, :movimientos_tipo], 
          :group  => 'movimiento_ganados.ganado_id',
          :conditions => ["fecha > ? and movimientos_tipos.tipo='m' and movimientos.predio_id = ? "+
            "and movimiento_ganados.ganado_id = ?", rec_mov.fecha, predio, self.id]
          )

         if mov.any?
          mov_salidas = mov.first.ing
        end

        # sumatoria de movimientos entradas
        mov = Movimiento.find(
          :all, 
          :select => 'SUM(movimiento_ganados.cant_sec) as ing',
          :joins => [:movimiento_ganados, :movimientos_tipo], 
          :group  => 'movimiento_ganados.ganado_id',
          :conditions => ["fecha > ? and movimientos_tipos.tipo='m' and movimientos.predio_sec_id = ? "+
            "and movimiento_ganados.ganado_id = ?", rec_mov.fecha, predio, self.id]
          )

         if mov.any?
          mov_entradas = mov.first.ing
        end

        return rec_cant + ingresos + mov_entradas - egresos - mov_salidas

      else
        return 0 # no existe ningun recuento (Inicial)
      end
    else
      # Hubo un recuento este mes, se devuelve su resultado
      print("*** " + rec_info[:mes_actual].to_s)
      mov = Movimiento.find(rec_info[:mes_actual], :joins => :ganados)
      return mov.movimiento_ganados.where("ganado_id = ?", self.id).first.cant
    end

  	

  end
end
