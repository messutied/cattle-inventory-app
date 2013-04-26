class CreateConfiguracions < ActiveRecord::Migration
  def change
    create_table :configuracions do |t|
      t.integer :mes_cambio_edades

      t.timestamps
    end
  end
end
