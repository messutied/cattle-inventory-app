module InventarioHelpers
  def crear_recuento_cero
    mov_ganados = []
    Ganado.all.each do |ganado|
      mov_ganados.push Fabricate(:movimiento_ganado, cant: 0, ganado: ganado)
    end

    Fabricate(:recuento, 
      predio: san_vicente,
      fecha: Time.now.change(day:1), 
      movimiento_ganados: mov_ganados)
  end

  def crear_ingreso(ganados_cant)
    ganados_arr = []
    ganados_cant.each_with_index do |ganado_cant, index|
      ganados_arr.push Fabricate(:movimiento_ganado, cant: ganado_cant, ganado: Ganado.all[index])
    end
    
    Fabricate(:ingreso, predio: san_vicente, movimientos_tipo: compra,
      fecha: Time.now.change(day:2), movimiento_ganados: ganados_arr)
  end
end