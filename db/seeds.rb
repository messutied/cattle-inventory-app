# -*- coding: utf-8 -*

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#

UserType.create([
  {:nombre => 'ADM'},
  {:nombre => 'Owner'},
  {:nombre => 'Encargado Ganaderia'},
  {:nombre => 'Encargado Proveedores'}
])


User.create([
  {:nombre=>'Eduardo Messuti', :username=>'edd', :mail=>'messuti.edd@gmail.com', :user_type_id=>1, :pass=>'126188'},
  {:nombre=>'Sebastian Nogales', :username=>'seba', :mail=>'snogalesc@gmail.com', :user_type_id=>1, :pass=>'sebastian12345'}
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
  {:nombre=>'Terneros de Meses'},
  {:nombre=>'De un Año'},
  {:nombre=>'Vacas de Cria'},
  {:nombre=>'Vacas de Descarte'},
  {:nombre=>'Toros'},
  {:nombre=>'Novillos'},
  {:nombre=>'Bueyes'}
])

Ganado.create([
  {:nombre=>'Hemb', :ganado_grupo_id=>1},
  {:nombre=>'Mach', :ganado_grupo_id=>1},
  {:nombre=>'Hemb', :ganado_grupo_id=>2},
  {:nombre=>'Tore', :ganado_grupo_id=>2},
  {:nombre=>'Nov', :ganado_grupo_id=>2},
  {:nombre=>'2A', :ganado_grupo_id=>3},
  {:nombre=>'3A', :ganado_grupo_id=>3},
  {:nombre=>'4 y MY', :ganado_grupo_id=>3},
  {:nombre=>'2A', :ganado_grupo_id=>4},
  {:nombre=>'3A', :ganado_grupo_id=>4},
  {:nombre=>'4 y MY', :ganado_grupo_id=>4},
  {:nombre=>'2A', :ganado_grupo_id=>5},
  {:nombre=>'3A', :ganado_grupo_id=>5},
  {:nombre=>'4 y MY', :ganado_grupo_id=>5},
  {:nombre=>'2A', :ganado_grupo_id=>6},
  {:nombre=>'3A', :ganado_grupo_id=>6},
  {:nombre=>'4 y MY', :ganado_grupo_id=>6},
  {:nombre=>' ', :ganado_grupo_id=>7}
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
