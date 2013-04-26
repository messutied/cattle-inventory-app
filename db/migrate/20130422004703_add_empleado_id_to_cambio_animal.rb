class AddEmpleadoIdToCambioAnimal < ActiveRecord::Migration
  def change
    add_column :cambio_animals, :empleado_id, :integer

    add_column :cambio_animals, :fecha, :date

  end
end
