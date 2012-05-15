class AddOrdenToGrupoGanado < ActiveRecord::Migration
  def self.up
    add_column :ganado_grupos, :orden, :integer
  end

  def self.down
    remove_column :ganado_grupos, :orden
  end
end
