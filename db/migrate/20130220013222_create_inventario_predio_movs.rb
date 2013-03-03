class CreateInventarioPredioMovs < ActiveRecord::Migration
  def change
    create_table :inventario_predio_movs do |t|
      t.integer :inventario_predio_id
      t.string :tipo, limit: 10
      t.integer :predio_sec_id
      t.integer :cant
      t.integer :cant_may_a
      t.integer :cant_men_a

      t.timestamps
    end
  end
end
