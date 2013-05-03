class AddSaldoPreRecToInventarioPredioGanado < ActiveRecord::Migration
  def change
    add_column :inventario_predio_ganados, :saldo_pre_rec, :integer

  end
end
