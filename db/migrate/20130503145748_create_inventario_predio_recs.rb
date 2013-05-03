class CreateInventarioPredioRecs < ActiveRecord::Migration
  def change
    create_table :inventario_predio_recs do |t|
      t.integer :inventario_predio_id
      t.integer :cant
      t.integer :cant_may_a
      t.integer :cant_men_a

      t.timestamps
    end
  end
end
