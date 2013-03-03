class CreateInventarioPredioGanados < ActiveRecord::Migration
  def change
    create_table :inventario_predio_ganados do |t|
      t.integer :inventario_predio_id
      t.integer :ganado_id
      t.integer :cant
      t.integer :saldo_parcial

      t.timestamps
    end
  end
end
