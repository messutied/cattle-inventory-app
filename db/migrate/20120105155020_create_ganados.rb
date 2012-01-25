class CreateGanados < ActiveRecord::Migration
  def self.up
    create_table :ganados do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :ganados
  end
end
