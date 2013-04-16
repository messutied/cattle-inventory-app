class GanadoGrupo < ActiveRecord::Base
  has_many :ganados

  default_scope order("orden asc")
end
