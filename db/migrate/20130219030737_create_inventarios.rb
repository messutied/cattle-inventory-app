class CreateInventarios < ActiveRecord::Migration
  def change
    create_table :inventarios do |t|
      t.integer :gestion_id
      t.integer :cant
      t.integer :cant_may_a
      t.integer :cant_men_a

      t.timestamps
    end
  end
end
