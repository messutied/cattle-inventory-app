class AddGanadoRuposToGanado < ActiveRecord::Migration
  def self.up
    add_column :ganados, :ganado_grupo_id, :integer
  end

  def self.down
    remove_column :ganados, :ganado_grupo_id
  end
end
