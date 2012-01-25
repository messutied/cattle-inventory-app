class AddDataToMovimiento < ActiveRecord::Migration
  def self.up
    add_column :movimientos, :fecha, :date
    add_column :movimientos, :detalle, :string
  end

  def self.down
    remove_column :movimientos, :detalle
    remove_column :movimientos, :fecha
  end
end
