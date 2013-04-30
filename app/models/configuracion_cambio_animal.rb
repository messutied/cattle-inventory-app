class ConfiguracionCambioAnimal < ActiveRecord::Base
  belongs_to :configuracion
  belongs_to :ganado_desde, :class_name => "Ganado", :foreign_key => "ganado_desde_id"
  belongs_to :ganado_hasta, :class_name => "Ganado", :foreign_key => "ganado_hasta_id"
end
