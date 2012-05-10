class CreateGestions < ActiveRecord::Migration
  def self.up
    create_table :gestions do |t|
      t.integer :anio
      t.integer :mes
      t.boolean :estado

      t.timestamps
    end
  end

  def self.down
    drop_table :gestions
  end
end
