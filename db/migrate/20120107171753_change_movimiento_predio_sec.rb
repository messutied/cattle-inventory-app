class ChangeMovimientoPredioSec < ActiveRecord::Migration
  def self.up
    rename_column :movimientos, :predio_sec, :predio_sec_id
  end

  def self.down
    rename_column :movimientos, :predio_sec_id, :predio_sec
  end
end
