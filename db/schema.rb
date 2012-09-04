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

ActiveRecord::Schema.define(:version => 20120520204714) do

  create_table "ganado_grupos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "orden"
    t.string   "estado",     :limit => 1, :default => "A"
  end

  create_table "ganados", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "nombre_corto"
    t.integer  "ganado_grupo_id"
    t.integer  "orden"
    t.string   "estado",          :limit => 1, :default => "A"
  end

  create_table "gestions", :force => true do |t|
    t.integer  "anio"
    t.integer  "mes"
    t.string   "estado",     :limit => 1
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
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
