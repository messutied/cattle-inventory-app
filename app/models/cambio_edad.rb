class CambioEdad < CambioAnimal
  default_scope where(tipo: "c_edad")
  after_create -> { self.tipo = "c_edad" }

  def self.generate_from(attributes)
    cambio_edad = CambioEdad.new(attributes)
    cambio_edad.fecha = Time.now

    return cambio_edad
  end
end