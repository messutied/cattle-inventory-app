class InventarioGanado < ActiveRecord::Base
  belongs_to :inventario
  belongs_to :ganado

  default_scope joins(:ganado => [:ganado_grupo])
                .order("ganado_grupos.orden asc, ganados.orden asc")
                .select("inventario_ganados.*")
end
