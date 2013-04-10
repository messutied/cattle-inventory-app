class AddPerdidosToInventarioPredioMovGanados < ActiveRecord::Migration
  def change
    add_column :inventario_predio_mov_ganados, :perdidos, :integer

  end
end
