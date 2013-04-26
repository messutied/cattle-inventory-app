class AddGestionIdToCambioAnimal < ActiveRecord::Migration
  def change
    add_column :cambio_animals, :gestion_id, :integer

  end
end
