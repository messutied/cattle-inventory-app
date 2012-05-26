class Gestion < ActiveRecord::Base

	def desde
		#return "#{self.anio}-#{self.mes}-01"
		return self.anio.to_s+"-"+("%02d" % self.mes).to_s+"-01"
	end

	def hasta
		gestion_mes = self.mes

		if gestion_mes <= 11
			return self.anio.to_s+"-"+("%02d" % (self.mes+1)).to_s+"-01"
		else
			return (gestion_anio+1).to_s+"-01-01" # si es diciembre, pasar a enero
		end
	end

	def anterior
		if self.mes > 1
			return Gestion.find_by_anio_and_mes(self.anio, self.mes-1)
		else
			return Gestion.find_by_anio_and_mes(self.anio-1, 1)
		end
	end

	def self.get_gestion
		gestion_anio = Time.now.year
		gestion_mes = Time.now.month

		gesion_desde = gestion_anio.to_s+"-"+("%02d" % gestion_mes).to_s+"-01"

		if gestion_mes <= 11
			gesion_hasta = gestion_anio.to_s+"-"+("%02d" % (gestion_mes+1)).to_s+"-01"
		else
			gesion_hasta = (gestion_anio+1).to_s+"-01-01" # si es diciembre, pasar a enero
		end

		return {:desde => gesion_desde, :hasta => gesion_hasta}
	end

	def self.gestion_abierta
		@gestion = Gestion.find_by_estado("A")
		return @gestion
	end

	def self.gestion_abierta_str
		@gestion = Gestion.gestion_abierta()

		return @gestion.anio.to_s + "-" + @gestion.mes.to_s
	end

	def self.gestion_actual
		@gestion = Gestion.find_by_anio_and_mes(Time.now.year, Time.now.month)
		return @gestion
	end

	def self.gestion_ultima
    @gestions = Gestion.all(:order => "anio desc, mes desc", :limit => 1)

    return @gestions.first
	end

	def self.gestion_mas_antigua
		@gestions = Gestion.all(:order => "anio asc, mes asc", :limit => 1)

    return @gestions.first
	end
end
