class CreateInventarioPredioIngrEgrGanados < ActiveRecord::Migration
  def change
    create_table :inventario_predio_ingr_egr_ganados do |t|
      t.integer :inventario_predio_ingr_egr_id
      t.integer :ganado_id
      t.integer :cant

      t.timestamps
    end
  end
end
