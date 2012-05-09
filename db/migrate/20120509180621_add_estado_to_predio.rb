class AddEstadoToPredio < ActiveRecord::Migration
  def self.up
    add_column :predios, :estado, :string, :default => "A", :limit => 1
  end

  def self.down
    remove_column :predios, :estado
  end
end
