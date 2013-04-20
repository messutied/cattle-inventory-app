class CreateInventarioPredioCambioAnimals < ActiveRecord::Migration
  def change
    create_table :inventario_predio_cambio_animals do |t|
      t.integer :inventario_predio_id
      t.string :tipo

      t.timestamps
    end
  end
end
