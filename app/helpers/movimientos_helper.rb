module MovimientosHelper

  def day
    Time.now.day
  end

  def month
    Time.now.month
  end

  def year
    Time.now.year
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

  def get_all_ganado
    @all_ganado = Ganado.all.map { |g| [g.ganado_grupo.nombre+" "+g.nombre, g.id] }
    @all_ganado.unshift(["Seleccionar", ""])
  end

  def get_ganado_un_mes
    @ganado_un_mes = Ganado.un_mes.map { |g| [g.ganado_grupo.nombre+" "+g.nombre, g.id] }
    @ganado_un_mes.unshift(["Seleccionar", ""])
  end

  def get_predios
    @predios = Predio.all.map { |predio| [predio.nombre, predio.id] }
    @predios.unshift(["---", ""])
  end

  def get_days
    @days = (1..days_in_month(Time.now.month)).to_a.map {|e| [e, e]}
  end

end
