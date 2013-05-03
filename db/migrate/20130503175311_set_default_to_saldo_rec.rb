class SetDefaultToSaldoRec < ActiveRecord::Migration
  def up
    change_column :inventario_predios, :saldo_pre_r, :integer, default: 0
    change_column :inventario_predios, :saldo_pre_r_may_a, :integer, default: 0
    change_column :inventario_predios, :saldo_pre_r_men_a, :integer, default: 0
    change_column :inventario_predio_ganados, :saldo_pre_rec, :integer, default: 0
  end

  def down
    change_column :inventario_predios, :saldo_pre_r, :integer, default: nil
    change_column :inventario_predios, :saldo_pre_r_may_a, :integer, default: nil
    change_column :inventario_predios, :saldo_pre_r_men_a, :integer, default: nil
    change_column :inventario_predio_ganados, :saldo_pre_rec, :integer, default: nil
  end
end
