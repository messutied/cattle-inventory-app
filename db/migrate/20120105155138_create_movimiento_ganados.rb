class CreateMovimientoGanados < ActiveRecord::Migration
  def self.up
    create_table :movimiento_ganados do |t|
      t.integer :movimiento_id
      t.integer :ganado_id
      t.integer :cant
      t.integer :cant_sec

      t.timestamps
    end
  end

  def self.down
    drop_table :movimiento_ganados
  end
end
