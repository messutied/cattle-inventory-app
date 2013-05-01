# encoding: UTF-8

module ApplicationHelper

  def get_predios
    @predios = Predio.all.map { |predio| [predio.nombre, predio.id] }
    @predios.unshift(["Seleccionar", ""])
  end

  def get_all_ganado
    @all_ganado = Ganado.all.map { |g| [g.ganado_grupo.nombre+" "+g.nombre, g.id] }
    @all_ganado.unshift(["Seleccionar", ""])
  end

  def day
    Time.now.day
  end

  def month(mov)
    if mov.new_record?
      g = Gestion.gestion_abierta
      g.mes
    else
      mov.fecha.month
    end
  end

  def year(mov)
    if mov.new_record?
      g = Gestion.gestion_abierta
      g.anio
    else
      mov.fecha.year
    end
  end

  def options_for_gestiones(selected)
    gestiones = Gestion.order("anio DESC, mes DESC").map {|g| [g.anio.to_s+"-"+g.mes.to_s, g.id]}
    # gestiones.unshift(["Seleccionar", ""])
    return options_for_select(gestiones, selected)
  end

  def options_for_predios(selected, todos=false)
    predios = Predio.all.map {|p| [p.nombre, p.id]}
    if todos
      predios.unshift(["Todos", "*"])
    else
      predios.unshift(["Seleccionar...", ""])
    end
    return options_for_select(predios, selected)
  end

  def options_for_ganado_extra(selected)
    opts = [["Todos", "*"], ["Con pérdidas", "P"], ["Registros Incompletos", "I"], ["Incompletos + Pérdidas", "F"]]
    return options_for_select(opts, selected)
  end

  def link_to_add_fields(name, f, association, form)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(form, {:f => builder, :no_select => true})
    end
    link_to_function(name, raw("AGan.add_#{association}_fields(this, '#{association}', '#{escape_javascript(fields)}')"), :id => "add_mov")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "AGan.remove_fields(this)")
  end

  def we_are_in(controller, action=nil)
      return (params[:controller] == controller and params[:action] == action) if action.present?

      params[:controller] == controller
    end

  def nav_sel(page)
    param_type = params[:type]
    active = raw(" class=\"active\"")

    case page
    when "home"
      if self.we_are_in("home")
        return active 
      end
    when "in_eg_new"
      if we_are_in("movimientos", "new") and param_type == "in_eg"
        return active
      end
    when "mov_new"
      if we_are_in("movimientos", "new") and param_type == "mov"
        return active
      end
    when "rec_new"
      if we_are_in("movimientos", "new") and param_type == "rec"
        return active
      end
    when "in_eg_list"
      if we_are_in("movimientos", "index") and param_type == "in_eg"
        return active
      end
    when "mov_list"
      if we_are_in("movimientos", "index") and param_type == "mov"
        return active
      end
    when "rec_list"
      if we_are_in("movimientos", "index") and param_type == "rec"
        return active
      end
    when "mov_tipos_list"
      if we_are_in("movimientos_tipos", "index")
        return active
      end
    when "rep_inv_mensual"
      if we_are_in("reports", "inventario_mensual")
        return active
      end
    when "config_gestion"
      if we_are_in("gestions", "index")
        return active
      end
    when "empleados_list"
      if we_are_in("empleados", "index")
        return active
      end
    when "descartes_new"
      if we_are_in("descartes", "new")
        return active
      end
    when "descartes_list"
      if we_are_in("descartes", "index")
        return active
      end
    when "config_cambio_edad"
      if we_are_in("configuracions", "cambio_edad")
        return active
      end
    when "config_descartes"
      if we_are_in("configuracions", "descartes")
        return active
      end
    when "cambio_edad"
      if we_are_in("cambio_edads", "index")
        return active
      end
    end
  end
end
