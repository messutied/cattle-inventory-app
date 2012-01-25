 class CreateUsers < ActiveRecord::Migration
   def self.up
     create_table :users do |t|
       t.integer :user_type_id
       t.string :username
       t.string :mail
       t.string :nombre
       t.string :pass
 
       t.timestamps
     end
   end
 
   def self.down
     drop_table :users
   end
 end
