class AddEstadoToMovimientosTipo < ActiveRecord::Migration
  def self.up
    add_column :movimientos_tipos, :estado, :string, :default => "A", :limit => 1
  end

  def self.down
    remove_column :movimientos_tipos, :estado
  end
end
