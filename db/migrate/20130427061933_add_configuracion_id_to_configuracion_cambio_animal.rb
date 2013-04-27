class AddConfiguracionIdToConfiguracionCambioAnimal < ActiveRecord::Migration
  def change
    add_column :configuracion_cambio_animals, :configuracion_id, :integer

  end
end
