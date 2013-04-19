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
