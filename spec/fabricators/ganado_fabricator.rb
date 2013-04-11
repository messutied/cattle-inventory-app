Fabricator :ganado_grupo do
  nombre "grupo 1"
  ganados(count: 2) do |attrs, i| 
    Fabricate(:ganado, 
      nombre: "Ganado #{i}", 
      nombre_corto: "G #{i}", 
      orden: i,
      # pares   = mayores al año
      # impares = menores al año
      tipo: i%2 == 0 ? "may_a" : "men_a"
    )
  end
end

Fabricator :ganado