module MovimientosTiposHelper

  def tipo(tipo)
    case tipo
    when "i"
      return raw "<span style='color: green'>Ingreso</span>"
    when "e"
      return raw "<span style='color: orange'>Egreso</span>"
    when "r"
      return raw "<span style='color: black'>Recuento</span>"
    when "m"
      return raw "<span style='color: gray'>Movimiento</span>"
    end
  end
end
