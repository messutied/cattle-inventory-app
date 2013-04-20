class CreateInventarioPredioCambioAnimalGanados < ActiveRecord::Migration
  def change
    create_table :inventario_predio_cambio_animal_ganados do |t|
      t.integer :inventario_predio_cambio_animal_id
      t.integer :ganado_id
      t.integer :cant_salida
      t.integer :cant_entrada

      t.timestamps
    end
  end
end
