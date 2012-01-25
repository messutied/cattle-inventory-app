class AddTipoToMovimientosTipo < ActiveRecord::Migration
  def self.up
    add_column :movimientos_tipos, :tipo, :string
  end

  def self.down
    remove_column :movimientos_tipos, :tipo
  end
end
