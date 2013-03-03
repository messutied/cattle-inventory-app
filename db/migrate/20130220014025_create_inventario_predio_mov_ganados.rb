class CreateInventarioPredioMovGanados < ActiveRecord::Migration
  def change
    create_table :inventario_predio_mov_ganados do |t|
      t.integer :inventario_predio_mov_id
      t.integer :ganado_id
      t.integer :cant

      t.timestamps
    end
  end
end
