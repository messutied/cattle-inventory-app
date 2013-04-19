module GestionsHelper
  def estado(estado)
    case estado
      when "A"
        return raw "<span class='label label-important'>Abierta</span>"

      when "C"
        return "Cerrada"
    end
  end

  def abrir_gestion_path(gestion)
    return "/gestions/abrir/#{gestion.id}"
  end
  
  def cerrar_gestion_path(gestion)
    return "/gestions/cerrar/#{gestion.id}"
  end

  def gestiones_anteriores_opciones
    @gestiones_anteriores = ["Seleccionar..."]

    @gestion_antigua = Gestion.gestion_mas_antigua
    @gestion_ultima = Gestion.gestion_ultima

    @gestion_ultima.anio.downto( @gestion_antigua.anio ) do |anio|
      12.downto(1) do |mes|
        @g = Gestion.find_by_anio_and_mes(anio, mes)
        if @g == nil and (anio != Time.now.year or mes < Time.now.month)
          @gestiones_anteriores.push([anio.to_s+"-"+mes.to_s])
        end
      end
    end

    return @gestiones_anteriores
  end
end
