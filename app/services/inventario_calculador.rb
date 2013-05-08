class InventarioCalculador
  def initialize(inventario)
    @inventario = inventario
    @config_cambios_edad = ConfiguracionCambioEdad.all
    @inventario_predios = @inventario.inventario_predios
  end

  def calcular_cambio_edades
    @inventario.inventario_predios.each do |inv_predio|
      inv_predio.inventario_predio_cambio_animals.cambios_edad.destroy_all

      # si hay un cambio de edad (no deberia haber mas de 1 en una gestion)
      if not @inventario.gestion.cambio_animals.cambios_edad.empty?
        ip_cambio_animal = inv_predio.inventario_predio_cambio_animals.cambios_edad.create

        @config_cambios_edad.each do |c_cambio_edad|
          ip_ganado = inv_predio.inventario_predio_ganados
                      .find_by_ganado_id(c_cambio_edad.ganado_desde_id)

          next if ip_ganado.nil?

          ganado_desde = ip_cambio_animal.inventario_predio_cambio_animal_ganados
            .find_or_initialize_by_ganado_id(c_cambio_edad.ganado_desde_id)

          ganado_desde.update_attributes(cant_salida: ganado_desde.cant_salida + ip_ganado.cant)
          # puts "#{c_cambio_edad.ganado_desde_id} -> #{c_cambio_edad.ganado_hasta_id} (#{ip_ganado.cant})"

          ganado_hasta = ip_cambio_animal.inventario_predio_cambio_animal_ganados
            .find_or_initialize_by_ganado_id(c_cambio_edad.ganado_hasta_id)

          ganado_hasta.update_attributes(cant_entrada: ganado_hasta.cant_entrada + ip_ganado.cant)
        end

        inv_predio.inventario_predio_cambio_animals.cambios_edad.each do |ip_cambio_edad|
          missing = Ganado.where("ganados.id not in (?)", 
            ip_cambio_edad.inventario_predio_cambio_animal_ganados.map(&:ganado_id) )

          missing.each do |ganado|
            ip_cambio_edad.inventario_predio_cambio_animal_ganados
              .create(ganado_id: ganado.id, cant_salida: 0, cant_entrada: 0)
          end
        end
      end
    end
  end

  def calcular_totales
    @inventario_predios.each do |inv_predio|
      InventarioPredioCalculador.new(inv_predio).calcular_totales
    end
  end

  def calcular_inventario_ganados_totales
    Ganado.all.each do |ganado|
      total = 0
      @inventario_predios.each do |predio|
        ip_ganado = predio.inventario_predio_ganados.find_by_ganado_id(ganado.id)
        total += ip_ganado ? ip_ganado.cant : 0
      end

      inv_ganado = @inventario.inventario_ganados.find_or_create_by_ganado_id(ganado.id)
      inv_ganado.update_attributes(cant: total)
    end
  end
end