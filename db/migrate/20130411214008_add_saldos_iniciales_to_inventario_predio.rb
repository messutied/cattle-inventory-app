class AddSaldosInicialesToInventarioPredio < ActiveRecord::Migration
  def change
    add_column :inventario_predios, :saldo_i, :integer
    add_column :inventario_predios, :saldo_i_may_a, :integer
    add_column :inventario_predios, :saldo_i_men_a, :integer
  end
end
