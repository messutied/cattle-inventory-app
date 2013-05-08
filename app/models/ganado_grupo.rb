class GanadoGrupo < ActiveRecord::Base
  has_many :ganados, dependent: :destroy

  default_scope order("orden asc")
end
