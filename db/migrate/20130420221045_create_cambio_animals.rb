class CreateCambioAnimals < ActiveRecord::Migration
  def change
    create_table :cambio_animals do |t|
      t.integer :predio_id
      t.string :detalle
      t.string :tipo, limit: 10

      t.timestamps
    end
  end
end
