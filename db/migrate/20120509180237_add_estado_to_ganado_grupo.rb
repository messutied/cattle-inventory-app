class AddEstadoToGanadoGrupo < ActiveRecord::Migration
  def self.up
    add_column :ganado_grupos, :estado, :string, :default => "A", :limit => 1
  end

  def self.down
    remove_column :ganado_grupos, :estado
  end
end
