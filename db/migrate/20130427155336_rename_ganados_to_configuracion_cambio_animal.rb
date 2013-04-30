class RenameGanadosToConfiguracionCambioAnimal < ActiveRecord::Migration
  def self.up
    rename_column :configuracion_cambio_animals, :ganado_desde, :ganado_desde_id
    rename_column :configuracion_cambio_animals, :ganado_hasta, :ganado_hasta_id
  end

  def self.down
    rename_column :configuracion_cambio_animals, :ganado_desde_id, :ganado_desde
    rename_column :configuracion_cambio_animals, :ganado_hasta_id, :ganado_hasta
  end
end
