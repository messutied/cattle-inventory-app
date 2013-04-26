class CreateConfiguracionCambioAnimals < ActiveRecord::Migration
  def change
    create_table :configuracion_cambio_animals do |t|
      t.string :tipo, limit: 10
      t.integer :ganado_desde
      t.integer :ganado_hasta

      t.timestamps
    end
  end
end
