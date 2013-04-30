Fabricator :gestion do
  anio { Time.now.year }
  mes { Time.now.month }
  estado 'A'
end

Fabricator :anterior, from: :gestion do
  anio { Time.now.year }
  mes { Time.now.month }
  estado 'C'
end