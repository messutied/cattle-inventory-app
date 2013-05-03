class SetDefaultsToInventarioPredioRec < ActiveRecord::Migration
  def up
    change_column :inventario_predio_recs, :cant, :integer, default: 0
    change_column :inventario_predio_recs, :cant_may_a, :integer, default: 0
    change_column :inventario_predio_recs, :cant_men_a, :integer, default: 0
    change_column :inventario_predio_rec_ganados, :cant, :integer, default: 0
  end

  def down
    change_column :inventario_predio_recs, :cant, :integer, default: nil
    change_column :inventario_predio_recs, :cant_may_a, :integer, default: nil
    change_column :inventario_predio_recs, :cant_men_a, :integer, default: nil
    change_column :inventario_predio_rec_ganados, :cant, :integer, default: nil
  end
end
