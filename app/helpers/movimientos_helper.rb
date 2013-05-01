module MovimientosHelper

  def movimientos_mix_path(mov)
    if mov.type_str == "in_eg"
      return "/ingreso-egreso/list"
    elsif mov.type_str == "mov"
      return "/movimiento/list"
    else
      return "/recuento/list"
    end
  end

  def fields_form(type)
      if type == "mov"
        return "movimiento_ganado_fields"
      elsif type == "in_eg"
        return "ingreso_egreso_ganado_fields"
      elsif type == "rec"
        return "recuento_ganado_fields"
      end
  end

  def get_movimientos
    @movimientos = MovimientosTipo.movimientos.map { |t| [t.nombre, t.id] }
    @movimientos.unshift(["Seleccionar", ""])
  end

  def get_ganado_un_mes
    @ganado_un_mes = Ganado.menor_anio.map { |g| [g.ganado_grupo.nombre+" "+g.nombre, g.id] }
    @ganado_un_mes.unshift(["Seleccionar", ""])
  end

  def get_days
    @days = (1..days_in_month(Gestion.gestion_abierta.mes)).to_a.map {|e| [e, e]}
  end

  def get_empleados
    emp = Empleado.all.map { |emp| [emp.nombre, emp.id] }
    emp.unshift(["Seleccionar", ""])
  end

end
