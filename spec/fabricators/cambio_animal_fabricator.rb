Fabricator :descarte, from: :cambio_animal do
  fecha Time.now
  detalle { Faker::Lorem.words(5) }
  empleado
  tipo { "descarte" }
end