class AddGestionIdToMovimientos < ActiveRecord::Migration
  def change
    add_column :movimientos, :gestion_id, :integer

  end
end
