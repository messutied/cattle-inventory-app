class AddEstadoToGanado < ActiveRecord::Migration
  def self.up
    add_column :ganados, :estado, :string, :default => "A", :limit => 1
  end

  def self.down
    remove_column :ganados, :estado
  end
end
