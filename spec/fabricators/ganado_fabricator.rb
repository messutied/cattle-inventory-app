Fabricator :ganado_grupo do
  gg_nombre_n = GanadoGrupo.last ? GanadoGrupo.last.id + 1 : 1
  g_nombre_n = Ganado.last ? Ganado.last.id : 1

  nombre "grupo #{gg_nombre_n}"
  ganados(count: 2) do |attrs, i| 
    g_nombre_n += i

    Fabricate(:ganado, 
      nombre: "Ganado #{g_nombre_n}", 
      nombre_corto: "G #{g_nombre_n}", 
      orden: g_nombre_n,
      # impares = menores al año
      # pares   = mayores al año
      tipo: i%2 == 0 ? "may_a" : "men_a"
    )
  end
end

Fabricator :ganado