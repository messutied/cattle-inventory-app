module ReportsHelper
  def perdidas_dcontent(mov_gan)
    perdida = (mov_gan.any?  and mov_gan.first.cant_sec and mov_gan.first.cant > mov_gan.first.cant_sec)
    
    if perdida
      "Enviados: <b>"+mov_gan.first.cant.to_s+"</b>"+
      " - Recividos: <b>"+mov_gan.first.cant_sec.to_s+"</b> "+
      "<br> Animales perdidos: <span class='badge badge-important'>"+
      (mov_gan.first.cant-mov_gan.first.cant_sec).to_s+"</span>"
    else
      return ""
    end
  end

  def perdidas_class(mov_gan)
    perdida = (mov_gan.any?  and mov_gan.first.cant_sec and mov_gan.first.cant > mov_gan.first.cant_sec)

    return perdida ? "perdida" : ""
  end

  def perdidas_link(mov_gan)
    perdida = (mov_gan.any?  and mov_gan.first.cant_sec and mov_gan.first.cant > mov_gan.first.cant_sec)

    if perdida
      return "javascript:window.open('/movimiento/list?filtro_gestion="+@gestion.id.to_s+
             "&filtro_predio="+mov_gan.first.movimiento.predio_id.to_s+"&filtro_extra=P')"
    else
      return ""
    end
  end
end
