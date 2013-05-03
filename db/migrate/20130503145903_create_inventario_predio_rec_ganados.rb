class CreateInventarioPredioRecGanados < ActiveRecord::Migration
  def change
    create_table :inventario_predio_rec_ganados do |t|
      t.integer :inventario_predio_rec_id
      t.integer :cant

      t.timestamps
    end
  end
end
