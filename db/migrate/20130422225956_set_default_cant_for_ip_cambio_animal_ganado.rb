class SetDefaultCantForIpCambioAnimalGanado < ActiveRecord::Migration
  def up
    change_column :inventario_predio_cambio_animal_ganados, :cant_salida, :integer, default: 0
    change_column :inventario_predio_cambio_animal_ganados, :cant_entrada, :integer, default: 0
  end

  def down
    change_column :inventario_predio_cambio_animal_ganados, :cant_salida, :integer, default: nil
    change_column :inventario_predio_cambio_animal_ganados, :cant_entrada, :integer, default: nil
  end
end
