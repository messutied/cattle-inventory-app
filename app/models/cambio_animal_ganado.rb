class CambioAnimalGanado < ActiveRecord::Base
  belongs_to :cambio_animal
  belongs_to :ganado
  belongs_to :ganado_sec, :class_name => "Ganado", :foreign_key => "ganado_sec_id"
end
