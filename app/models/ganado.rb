class Ganado < ActiveRecord::Base
  belongs_to :ganado_grupo
  has_many :movimiento_ganados, :dependent => :destroy
  has_many :movimientos, :through => :movimiento_ganados, :uniq => true

  default_scope joins(:ganado_grupo)
    .order("ganado_grupos.orden asc, ganados.orden asc")
    .select("ganados.*")
 end
