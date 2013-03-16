Fabricator :ingreso, from: :movimiento do
  predio(fabricator: :san_vicente)
  movimientos_tipo(fabricator: :compra)
  fecha Time.now
  detalle { Faker::Lorem.words(5) }
  empleado
end

Fabricator :egreso, from: :movimiento do
  predio(fabricator: :san_vicente)
  movimientos_tipo(fabricator: :venta)
  fecha Time.now
  detalle { Faker::Lorem.words(5) }
  empleado
end