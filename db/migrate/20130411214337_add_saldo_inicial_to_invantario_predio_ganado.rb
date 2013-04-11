class AddSaldoInicialToInvantarioPredioGanado < ActiveRecord::Migration
  def change
    add_column :inventario_predio_ganados, :saldo_inicial, :integer
  end
end
