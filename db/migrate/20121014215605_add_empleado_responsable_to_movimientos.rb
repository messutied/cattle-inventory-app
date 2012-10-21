class AddEmpleadoResponsableToMovimientos < ActiveRecord::Migration
  def change
    add_column :movimientos, :empleado_id, :integer

  end
end
