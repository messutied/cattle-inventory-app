class Ganado < ActiveRecord::Base
  belongs_to :ganado_grupo
  has_many :movimiento_ganados, dependent: :destroy
  has_many :movimientos, through: :movimiento_ganados, uniq: true

  has_many :cambio_animal_ganados, dependent: :destroy
  has_many :cambio_animals, through: :cambio_animal_ganados, uniq: true

  default_scope joins(:ganado_grupo)
    .order("ganado_grupos.orden asc, ganados.orden asc")
    .select("ganados.*")

  scope :menor_anio, where(tipo: "men_a")
  scope :mayor_anio, where(tipo: "may_a")
  scope :descartable, includes(:ganado_grupo)
    .order("ganado_grupos.orden asc, ganados.orden asc")
    .where("ganados.id in (?)", [6,7,8])


  def self.descarte_de(ganado_id)
    a_descartar = Ganado.find(ganado_id)

    Ganado.joins(:ganado_grupo).where(
      "ganado_grupos.nombre = ? and ganados.nombre = ?", 
      "Vacas de Descarte", a_descartar.nombre
    ).first
  end

  def nombre_completo
    ganado_grupo.nombre+" "+nombre
  end
 end
