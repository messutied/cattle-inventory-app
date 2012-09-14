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

end
