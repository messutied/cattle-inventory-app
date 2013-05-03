class AddSaldoPreRecToInventarioPredio < ActiveRecord::Migration
  def change
    add_column :inventario_predios, :saldo_pre_r, :integer

    add_column :inventario_predios, :saldo_pre_r_may_a, :integer

    add_column :inventario_predios, :saldo_pre_r_men_a, :integer

  end
end
