class AddShortNameToGanado < ActiveRecord::Migration
  def self.up
    add_column :ganados, :short_name, :string
  end

  def self.down
    remove_column :ganados, :short_name
  end
end
