class Gestion < ActiveRecord::Base
	has_one :inventario
	has_many :cambio_animals

	def to_str
		return self.anio.to_s + "-" + self.mes.to_s
	end

	def get_inventario
		return inventario if inventario

		self.inventario = Inventario.create(gestion: self)
		save

		return self.inventario
	end

	def desde
		gmes = "%02d" % self.mes
		return "#{anio}-#{gmes}-01"
	end

	def hasta
		gmes = "%02d" % self.mes
		return "#{anio}-#{gmes}-#{days_in_month(self.mes)}"
	end

	def anterior
		g_date = Date.parse(desde).advance(months: -1)
		Gestion.find_by_anio_and_mes(g_date.year, g_date.month)
	end

	def abrir
		abierta = Gestion.gestion_abierta
		abierta.update_attributes(estado: "C") if abierta
		update_attributes(estado: "A")
	end

	def es_actual
		Date.parse(hasta) >= Date.today
	end

	def self.gestion_abierta
		Gestion.find_by_estado("A")
	end

	def self.gestion_actual
		Gestion.find_or_create_by_anio_and_mes(Time.now.year, Time.now.month)
	end

	def self.gestion_ultima
    Gestion.all(:order => "anio desc, mes desc", :limit => 1).first
	end

	def self.gestion_mas_antigua
		Gestion.all(:order => "anio asc, mes asc", :limit => 1).first
	end
end
