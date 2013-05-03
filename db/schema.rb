# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130503175311) do

  create_table "cambio_animal_ganados", :force => true do |t|
    t.integer  "cambio_animal_id"
    t.integer  "ganado_id"
    t.integer  "ganado_sec_id"
    t.integer  "cant"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "cambio_animals", :force => true do |t|
    t.integer  "predio_id"
    t.string   "detalle"
    t.string   "tipo",        :limit => 10
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "gestion_id"
    t.integer  "empleado_id"
    t.date     "fecha"
  end

  create_table "configuracion_cambio_animals", :force => true do |t|
    t.string   "tipo",             :limit => 10
    t.integer  "ganado_desde_id"
    t.integer  "ganado_hasta_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "configuracion_id"
  end

  create_table "configuracions", :force => true do |t|
    t.integer  "mes_cambio_edades"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "empleados", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ganado_grupos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "orden"
    t.string   "estado",     :limit => 1, :default => "A"
  end

  create_table "ganados", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "nombre_corto"
    t.integer  "ganado_grupo_id"
    t.integer  "orden"
    t.string   "estado",          :limit => 1,  :default => "A"
    t.string   "tipo",            :limit => 10
  end

  create_table "gestions", :force => true do |t|
    t.integer  "anio"
    t.integer  "mes"
    t.string   "estado",     :limit => 1
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "inventario_ganados", :force => true do |t|
    t.integer  "inventario_id"
    t.integer  "ganado_id"
    t.integer  "cant",          :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "inventario_predio_cambio_animal_ganados", :force => true do |t|
    t.integer  "inventario_predio_cambio_animal_id"
    t.integer  "ganado_id"
    t.integer  "cant_salida",                        :default => 0
    t.integer  "cant_entrada",                       :default => 0
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "inventario_predio_cambio_animals", :force => true do |t|
    t.integer  "inventario_predio_id"
    t.string   "tipo"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "inventario_predio_ganados", :force => true do |t|
    t.integer  "inventario_predio_id"
    t.integer  "ganado_id"
    t.integer  "cant",                 :default => 0
    t.integer  "saldo_parcial",        :default => 0
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "saldo_inicial"
    t.integer  "saldo_pre_rec",        :default => 0
  end

  create_table "inventario_predio_ingr_egr_ganados", :force => true do |t|
    t.integer  "inventario_predio_ingr_egr_id"
    t.integer  "ganado_id"
    t.integer  "cant",                          :default => 0
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "inventario_predio_ingr_egrs", :force => true do |t|
    t.integer  "inventario_predio_id"
    t.integer  "movimientos_tipo_id"
    t.integer  "cant",                 :default => 0
    t.integer  "cant_may_a",           :default => 0
    t.integer  "cant_men_a",           :default => 0
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "inventario_predio_mov_ganados", :force => true do |t|
    t.integer  "inventario_predio_mov_id"
    t.integer  "ganado_id"
    t.integer  "cant",                     :default => 0
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "perdidos"
    t.boolean  "incompletos",              :default => false
  end

  create_table "inventario_predio_movs", :force => true do |t|
    t.integer  "inventario_predio_id"
    t.string   "tipo",                 :limit => 10
    t.integer  "predio_sec_id"
    t.integer  "cant",                               :default => 0
    t.integer  "cant_may_a",                         :default => 0
    t.integer  "cant_men_a",                         :default => 0
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "inventario_predio_rec_ganados", :force => true do |t|
    t.integer  "inventario_predio_rec_id"
    t.integer  "cant",                     :default => 0
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "ganado_id"
  end

  create_table "inventario_predio_recs", :force => true do |t|
    t.integer  "inventario_predio_id"
    t.integer  "cant",                 :default => 0
    t.integer  "cant_may_a",           :default => 0
    t.integer  "cant_men_a",           :default => 0
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "inventario_predios", :force => true do |t|
    t.integer  "inventario_id"
    t.integer  "predio_id"
    t.integer  "cant",              :default => 0
    t.integer  "cant_may_a",        :default => 0
    t.integer  "cant_men_a",        :default => 0
    t.integer  "saldo_p"
    t.integer  "saldo_p_may_a"
    t.integer  "saldo_p_men_a"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "saldo_i"
    t.integer  "saldo_i_may_a"
    t.integer  "saldo_i_men_a"
    t.integer  "saldo_pre_r",       :default => 0
    t.integer  "saldo_pre_r_may_a", :default => 0
    t.integer  "saldo_pre_r_men_a", :default => 0
  end

  create_table "inventarios", :force => true do |t|
    t.integer  "gestion_id"
    t.integer  "cant",       :default => 0
    t.integer  "cant_may_a", :default => 0
    t.integer  "cant_men_a", :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "movimiento_ganados", :force => true do |t|
    t.integer  "movimiento_id"
    t.integer  "ganado_id"
    t.integer  "cant"
    t.integer  "cant_sec"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "movimientos", :force => true do |t|
    t.integer  "predio_id"
    t.integer  "predio_sec_id"
    t.integer  "movimientos_tipo_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.date     "fecha"
    t.string   "detalle"
    t.integer  "empleado_id"
    t.integer  "gestion_id"
  end

  create_table "movimientos_tipos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "tipo"
    t.string   "estado",     :limit => 1, :default => "A"
  end

  create_table "predios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "estado",     :limit => 1, :default => "A"
  end

  create_table "user_types", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "user_type_id"
    t.string   "username"
    t.string   "mail"
    t.string   "nombre"
    t.string   "pass"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
