# -*- coding: utf-8 -*

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#

Gestion.create([
  {:anio => Time.now.year, :mes => Time.now.month, :estado => "A"},
  {:anio => Time.now.year, :mes => Time.now.month-1, :estado => "C"}
])

UserType.create([
  {:nombre => 'ADM'},
  {:nombre => 'Owner'},
  {:nombre => 'Encargado Ganaderia'},
  {:nombre => 'Encargado Proveedores'}
])


User.create([
  {:nombre=>'Eduardo Messuti', :username=>'edd', :mail=>'messuti.edd@gmail.com', :user_type_id=>1, :pass=>'126188'},
  {:nombre=>'Demo User', :username=>'demo', :mail=>'demo@demo.com', :user_type_id=>2, :pass=>'demo'},
  {:nombre=>'Juan', :username=>'juan', :mail=>'juan@demo.com', :user_type_id=>3, :pass=>'demo'}
])

Predio.create([
  {:nombre=>'San Vicente'},
  {:nombre=>'Camba Muerto'},
  {:nombre=>'Santiago'},
  {:nombre=>'La Laguna'},
  {:nombre=>'Nancy'},
  {:nombre=>'Trebol'},
  {:nombre=>'Santa Rosita'},
  {:nombre=>'Tujuju'},
  {:nombre=>'Quita Pesares'},
  {:nombre=>'Miramar'},
  {:nombre=>'Platanillo'}
])

GanadoGrupo.create([
  {:nombre=>'Terneros de Meses', :orden => 1},
  {:nombre=>'De un Año', :orden => 2},
  {:nombre=>'Vacas de Cria', :orden =>3 },
  {:nombre=>'Vacas de Descarte', :orden =>4 },
  {:nombre=>'Toros', :orden =>5 },
  {:nombre=>'Novillos', :orden =>6 },
  {:nombre=>'Bueyes', :orden =>7 }
])

Ganado.create([
  {:nombre=>'Hemb', :ganado_grupo_id=>1, :orden => 1, :tipo => "men_a"},
  {:nombre=>'Mach', :ganado_grupo_id=>1, :orden => 2, :tipo => "men_a"},
  {:nombre=>'Hemb', :ganado_grupo_id=>2, :orden => 1, :tipo => "may_a"},
  {:nombre=>'Tore', :ganado_grupo_id=>2, :orden => 2, :tipo => "may_a"},
  {:nombre=>'Nov', :ganado_grupo_id=>2, :orden => 3, :tipo => "may_a"},
  {:nombre=>'2A', :ganado_grupo_id=>3, :orden => 1, :tipo => "may_a"},
  {:nombre=>'3A', :ganado_grupo_id=>3, :orden => 2, :tipo => "may_a"},
  {:nombre=>'4 y MY', :ganado_grupo_id=>3, :orden => 3, :tipo => "may_a"},
  {:nombre=>'2A', :ganado_grupo_id=>4, :orden => 1, :tipo => "may_a"},
  {:nombre=>'3A', :ganado_grupo_id=>4, :orden => 2, :tipo => "may_a"},
  {:nombre=>'4 y MY', :ganado_grupo_id=>4, :orden => 3, :tipo => "may_a"},
  {:nombre=>'2A', :ganado_grupo_id=>5, :orden => 1, :tipo => "may_a"},
  {:nombre=>'3A', :ganado_grupo_id=>5, :orden => 2, :tipo => "may_a"},
  {:nombre=>'4 y MY', :ganado_grupo_id=>5, :orden => 3, :tipo => "may_a"},
  {:nombre=>'2A', :ganado_grupo_id=>6, :orden => 1, :tipo => "may_a"},
  {:nombre=>'3A', :ganado_grupo_id=>6, :orden => 2, :tipo => "may_a"},
  {:nombre=>'4 y MY', :ganado_grupo_id=>6, :orden => 3, :tipo => "may_a"},
  {:nombre=>' ', :ganado_grupo_id=>7, :orden => 1, :tipo => "may_a"}
])

MovimientosTipo.create([
  {:tipo => "m", :nombre => "Movimiento"},
  {:tipo => "i", :nombre => "Nacidos"},
  {:tipo => "i", :nombre => "Comprados"},
  {:tipo => "i", :nombre => "Recuperados"},
  {:tipo => "e", :nombre => "Muertes"},
  {:tipo => "e", :nombre => "Consumos"},
  {:tipo => "e", :nombre => "Ventas en Pie"},
  {:tipo => "e", :nombre => "Ventas en Matadero"},
  {:tipo => "r", :nombre => "Recuento"}
])

config = Configuracion.create(mes_cambio_edades: 9)

# config descartes
config.configuracion_descartes.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Cria", "2A").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Descarte", "2A").first,
)
config.configuracion_descartes.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Cria", "3A").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Descarte", "3A").first,
)
config.configuracion_descartes.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Cria", "4 y MY").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Descarte", "4 y MY").first,
)

# config cambios de edad
config.configuracion_cambio_edads.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Terneros de Meses", "Hemb").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "De un Año", "Hemb").first
)
config.configuracion_cambio_edads.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "De un Año", "Hemb").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Cria", "2A").first
)
config.configuracion_cambio_edads.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Cria", "2A").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Cria", "3A").first
)
config.configuracion_cambio_edads.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Cria", "3A").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Vacas de Cria", "4 y MY").first
)

config.configuracion_cambio_edads.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Terneros de Meses", "Mach").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "De un Año", "Tore").first
)
config.configuracion_cambio_edads.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "De un Año", "Tore").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Toros", "2A").first
)
config.configuracion_cambio_edads.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Toros", "2A").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Toros", "3A").first
)
config.configuracion_cambio_edads.create(
  ganado_desde: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Toros", "3A").first,
  ganado_hasta: Ganado.joins(:ganado_grupo).where("ganado_grupos.nombre = ? and ganados.nombre = ?", "Toros", "4 y MY").first
)