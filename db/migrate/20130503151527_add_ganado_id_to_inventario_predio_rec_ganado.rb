class AddGanadoIdToInventarioPredioRecGanado < ActiveRecord::Migration
  def change
    add_column :inventario_predio_rec_ganados, :ganado_id, :integer

  end
end
