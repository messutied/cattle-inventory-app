class CreateMovimientos < ActiveRecord::Migration
  def self.up
    create_table :movimientos do |t|
      t.integer :predio_id
      t.integer :predio_sec
      t.integer :movimientos_tipo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :movimientos
  end
end
