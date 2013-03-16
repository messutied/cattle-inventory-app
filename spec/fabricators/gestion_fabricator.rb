Fabricator :gestion do
  anio { Time.now.year }
  mes { Time.now.month }
  estado 'A'
end

Fabricator :anterior, from: :gestion do
  anio { Time.now.advance(months: -1).year }
  mes { Time.now.advance(months: -1).month }
  estado 'C'
end