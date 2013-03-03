class CreateInventarioGanados < ActiveRecord::Migration
  def change
    create_table :inventario_ganados do |t|
      t.integer :inventario_id
      t.integer :ganado_id
      t.integer :cant

      t.timestamps
    end
  end
end
