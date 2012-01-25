class CreateMovimientosTipos < ActiveRecord::Migration
  def self.up
    create_table :movimientos_tipos do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :movimientos_tipos
  end
end
