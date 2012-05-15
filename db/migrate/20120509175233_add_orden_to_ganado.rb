class AddOrdenToGanado < ActiveRecord::Migration
  def self.up
    add_column :ganados, :orden, :integer
  end

  def self.down
    remove_column :ganados, :orden
  end
end
