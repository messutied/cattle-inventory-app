class Ganado < ActiveRecord::Base
  belongs_to :ganado_grupo
  has_many :movimiento_ganado

  scope :un_mes, lambda {where("id=1 or id=2")}
end
