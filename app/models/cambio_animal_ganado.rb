class CambioAnimalGanado < ActiveRecord::Base
  belongs_to :cambio_animal
  belongs_to :ganado
end
