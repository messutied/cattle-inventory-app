# -*- coding: utf-8 -*-

module ReportsHelper

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

  def popover_link(mov_gan)
    perdida = (mov_gan.any?  and mov_gan.first.cant_sec and mov_gan.first.cant > mov_gan.first.cant_sec)
    incompleta = (mov_gan.any?  and not mov_gan.first.cant_sec)


    if perdida or incompleta
      fintro = perdida ? 'P' : 'I';

      return "javascript:window.open('/movimiento/list?filtro_gestion="+@gestion.id.to_s+
             "&filtro_predio="+mov_gan.first.movimiento.predio_id.to_s+"&filtro_extra="+fintro+"')"
    else
      return ""
    end
  end
end
