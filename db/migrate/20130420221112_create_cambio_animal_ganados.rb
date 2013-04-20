class CreateCambioAnimalGanados < ActiveRecord::Migration
  def change
    create_table :cambio_animal_ganados do |t|
      t.integer :cambio_animal_id
      t.integer :ganado_id
      t.integer :ganado_sec_id
      t.integer :cant

      t.timestamps
    end
  end
end
