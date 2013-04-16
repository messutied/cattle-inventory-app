class InventarioPredioMovGanado < ActiveRecord::Base
  belongs_to :inventario_predio_mov
  belongs_to :ganado

    default_scope joins(:ganado => [:ganado_grupo])
                .order("ganado_grupos.orden asc, ganados.orden asc")
                .select("inventario_predio_mov_ganados.*")
end
