class Ganado < ActiveRecord::Base
  belongs_to :ganado_grupo
  has_many :movimiento_ganados
  has_many :movimientos, :through => :movimiento_ganados

  scope :un_mes, lambda {where("id=1 or id=2")}

  def cant_inicial(predio)
  	gestion_anio = Time.now.year
  	gestion_mes = Time.now.month

  	gesion_desde = gestion_anio.to_s+"-"+("%02d" % gestion_mes).to_s+"-01"

  	if gestion_mes <= 11
  		gesion_hasta = gestion_anio.to_s+"-"+("%02d" % (gestion_mes+1)).to_s+"-01"
  	else
  		gesion_hasta = (gestion_anio+1).to_s+"-01-01" # si es diciembre, pasar a enero
  	end

  	# Revisar recuentos en el mes ("fecha >= ? and fecha < ?", gesion_desde, gesion_hasta)
  	mov = Movimiento.joins(:ganados).where("fecha >= ? and fecha < ?", gesion_desde, gesion_hasta)
  	return mov[0].movimiento_ganados.where("ganado_id = ?", self.id)[0].cant

  end
end
