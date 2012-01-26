class Ganado < ActiveRecord::Base
  belongs_to :ganado_grupo

  scope :un_mes, lambda {where("id=1 or id=2")}
end
