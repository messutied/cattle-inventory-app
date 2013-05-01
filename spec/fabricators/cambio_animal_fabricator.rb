Fabricator :descarte, from: :cambio_animal do
  fecha { Time.now }
  detalle { Faker::Lorem.words(5) }
  empleado
  tipo { "descarte" }
  gestion { Gestion.gestion_abierta }
end

Fabricator :cambio_edad, from: :cambio_animal do
  fecha { Time.now }
  detalle { Faker::Lorem.words(5) }
  empleado
  tipo { "c_edad" }
  gestion { Gestion.gestion_abierta }
end