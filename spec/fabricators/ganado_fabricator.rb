Fabricator :ganado_grupo do
  nombre "grupo 1"
  ganados(count: 2) do |attrs, i| 
    Fabricate(:ganado, 
      nombre: "Ganado #{i}", 
      nombre_corto: "G #{i}", 
      orden: i
    )
  end
end

Fabricator :ganado