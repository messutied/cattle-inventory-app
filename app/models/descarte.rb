class Descarte < CambioAnimal
  default_scope where(tipo: "descarte")
  after_create -> { self.tipo = "descarte" }

  validates :predio_id, :empleado_id, presence: true

  def self.new_with_descarte(attributes, ganado_id, cant)
    descarte = Descarte.new(attributes)

    descarte.cambio_animal_ganados.new(
      ganado_id: ganado_id, 
      ganado_sec: Ganado.descarte_de(ganado_id), 
      cant: cant
    )
    puts descarte.inspect
    descarte
  end

  def cant
    cambio_animal_ganados.first.cant unless new_record?
  end

  def ganado_descartado
    cambio_animal_ganados.first.ganado unless new_record?
  end

  def ganado_descartado_id
    ganado_descartado.id unless new_record?
  end
end