module ReportsHelper
  def options_for_gestiones(selected)
    gestiones = Gestion.all.map {|g| [g.anio.to_s+"-"+g.mes.to_s, g.id]}
    # gestiones.unshift(["Seleccionar", ""])
    return options_for_select(gestiones, selected)
  end

  def options_for_predios(selected)
    predios = Predio.all.map {|p| [p.nombre, p.id]}
    predios.unshift(["Seleccionar...", ""])
    return options_for_select(predios, selected)
  end
end
