class AlterGesionEstadoToChar < ActiveRecord::Migration
  def self.up
    change_column :gestions, :estado, :string, :limit => 1
  end

  def self.down
    change_column :gestions, :estado, :boolean
  end
end
