class AddIncompletosToInventarioPredioMovGanados < ActiveRecord::Migration
  def change
    add_column :inventario_predio_mov_ganados, :incompletos, :boolean, default: false

  end
end
