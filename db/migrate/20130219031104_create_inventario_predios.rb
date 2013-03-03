class CreateInventarioPredios < ActiveRecord::Migration
  def change
    create_table :inventario_predios do |t|
      t.integer :inventario_id
      t.integer :predio_id
      t.integer :cant
      t.integer :cant_may_a
      t.integer :cant_men_a
      t.integer :saldo_p
      t.integer :saldo_p_may_a
      t.integer :saldo_p_men_a

      t.timestamps
    end
  end
end
