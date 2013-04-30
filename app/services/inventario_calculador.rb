class InventarioCalculador
  def initialize(inventario)
    @inventario = inventario
    @config_cambios_edad = ConfiguracionCambioEdad.all
  end

  def calculate_cambio_edades
    @inventario.inventario_predios.each do |inv_predio|
      inv_predio.inventario_predio_cambio_animals.cambios_edad.destroy_all

      ip_cambio_animal = inv_predio.inventario_predio_cambio_animals.cambios_edad.create

      @config_cambios_edad.each do |c_cambio_edad|
        ip_ganado = inv_predio.inventario_predio_ganados
                    .find_by_ganado_id(c_cambio_edad.ganado_desde_id)

        ganado_desde = ip_cambio_animal.inventario_predio_cambio_animal_ganados
          .find_or_initialize_by_ganado_id(c_cambio_edad.ganado_desde_id)

        ganado_desde.update_attributes(cant_salida: ganado_desde.cant_salida + ip_ganado.cant)
        # puts "#{c_cambio_edad.ganado_desde_id} -> #{c_cambio_edad.ganado_hasta_id} (#{ip_ganado.cant})"

        ganado_hasta = ip_cambio_animal.inventario_predio_cambio_animal_ganados
          .find_or_initialize_by_ganado_id(c_cambio_edad.ganado_hasta_id)

        ganado_hasta.update_attributes(cant_entrada: ganado_hasta.cant_entrada + ip_ganado.cant)
      end
    end
  end

  def calculate_totals
    @inventario.inventario_predios.each do |inv_predio|
      InventarioPredioCalculador.new(inv_predio).calculate_totals
    end
  end
end