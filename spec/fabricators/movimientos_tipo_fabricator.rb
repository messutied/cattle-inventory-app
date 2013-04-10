Fabricator :compra, from: :movimientos_tipo do 
  nombre 'Comprados'
  tipo 'i'
end

Fabricator :venta, from: :movimientos_tipo do 
  nombre 'Vendidos'
  tipo 'e'
end

Fabricator :tipo_recuento, from: :movimientos_tipo do 
  nombre 'Recuentos'
  tipo 'r'
end

Fabricator :tipo_movimiento, from: :movimientos_tipo do 
  nombre 'Movimientos'
  tipo 'm'
end