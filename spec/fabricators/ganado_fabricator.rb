Fabricator :ganado_grupo do
  nombre "grupo 1"
  ganados(count: 2) do |attrs, i| 
    Fabricate(:ganado, 
      nombre: "Ganado #{i}", 
      nombre_corto: "G #{i}", 
      orden: i,
      tipo: i%2 == 0 ? "may_a" : "men_a" # pares son mayores al año, impares son menores
    )
  end
end

Fabricator :ganado