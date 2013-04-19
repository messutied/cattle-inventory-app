# encoding: UTF-8

module ReportsHelper

  def popover(ip_ganado, gestion_id, predio_id)
    perdidos = ip_ganado.perdidos > 0
    incompletos = ip_ganado.incompletos
    title = "Info. Sobre Movimiento"
    link = popover_link(ip_ganado, gestion_id, predio_id)
    content = ""

    if perdidos
      cclass = "perdida"
      content = "<br> Animales perdidos: <span class=\"badge badge-important\">#{ip_ganado.perdidos}</span>"
    elsif incompletos
      cclass = "incompleta"
      content += "<br> Se encontraron registros incompletos"
    else
      return ""
    end

    return "data-title='#{title}' class='#{cclass}' data-content='#{content}' onclick='#{link}'"
  end

  def popover_title(mov_gan)
    perdida = (mov_gan.any?  and mov_gan.first.cant_sec and mov_gan.first.cant > mov_gan.first.cant_sec)
    incompleta = (mov_gan.any?  and not mov_gan.first.cant_sec)

    if perdida
      return "Info. Pérdida de Ganado"
    elsif incompleta
      return "Info. Registro Incompleto"
    else
      return ""
    end
  end

  def popover_dcontent(mov_gan)
    perdida = (mov_gan.any?  and mov_gan.first.cant_sec and mov_gan.first.cant > mov_gan.first.cant_sec)
    incompleta = (mov_gan.any?  and not mov_gan.first.cant_sec)
    
    if perdida
      "Enviados: <b>"+mov_gan.first.cant.to_s+"</b>"+
      " - Recividos: <b>"+mov_gan.first.cant_sec.to_s+"</b> "+
      "<br> Animales perdidos: <span class='badge badge-important'>"+
      (mov_gan.first.cant-mov_gan.first.cant_sec).to_s+"</span>"
      link = "javascript:window.open('/movimiento/list?filtro_gestion="+@gestion.id.to_s+
             "&filtro_predio="+mov_gan.first.movimiento.predio_id.to_s+"&filtro_extra="+fintro+"')"
    elsif incompleta
      return "Se ingresó un registro sin llenar el campo de <b>cantidad de ganado recivido</b>"
    else
      return ""
    end
  end

  def popover_class(mov_gan)
    perdida = (mov_gan.any?  and mov_gan.first.cant_sec and mov_gan.first.cant > mov_gan.first.cant_sec)
    incompleta = (mov_gan.any?  and not mov_gan.first.cant_sec)

    if perdida
      return "perdida"
    elsif incompleta
      return "incompleta"
    else
      return ""
    end
  end

  def popover_link(ip_ganado, gestion_id, predio_id)
    if ip_ganado.perdidos > 0
      if ip_ganado.incompletos
        fintro = "F"
      else
        fintro = "P"
      end
    else
      fintro = "I"
    end

    return "javascript:window.open(\"/movimiento/list?filtro_gestion=#{gestion_id}"+
           "&filtro_predio=#{predio_id}&filtro_extra=#{fintro}\")"
  end
end
