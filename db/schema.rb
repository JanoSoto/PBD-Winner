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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141203211552) do

  create_table "competencia", force: true do |t|
    t.string   "nombre_comp"
    t.text     "descripcion_comp"
    t.string   "tipo_comp"
    t.boolean  "ida_vuelta_comp"
    t.integer  "cant_part_comp"
    t.date     "fecha_inicio_comp"
    t.date     "fecha_termino_comp"
    t.integer  "cant_grupos_comp"
    t.integer  "cant_fases_comp"
    t.integer  "cant_arbitros_comp"
    t.integer  "cant_jug_tit"
    t.integer  "cant_jug_ban"
    t.integer  "cant_max_jug_comp"
    t.integer  "cant_mod_comp"
    t.boolean  "privacidad_comp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organizador_id"
  end

  add_index "competencia", ["organizador_id"], name: "index_competencia_on_organizador_id", using: :btree

  create_table "convocatoria", force: true do |t|
    t.integer  "jugador_id"
    t.integer  "participante_id"
    t.date     "fecha_con"
    t.integer  "duracion_con"
    t.integer  "num_camiseta_con"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "convocatoria", ["jugador_id"], name: "index_convocatoria_on_jugador_id", using: :btree
  add_index "convocatoria", ["participante_id"], name: "index_convocatoria_on_participante_id", using: :btree

  create_table "encuentros", force: true do |t|
    t.datetime "fecha_enc"
    t.integer  "tiro_libre_local_enc"
    t.integer  "tiro_esquina_local_enc"
    t.integer  "fuera_de_juego_local_enc"
    t.integer  "tiro_libre_visita_enc"
    t.integer  "tiro_esquina_visita_enc"
    t.integer  "fuera_de_juego_visita_enc"
    t.string   "duracion_enc"
    t.integer  "cant_publico_enc"
    t.integer  "gol_local_enc"
    t.integer  "gol_visita_enc"
    t.boolean  "def_penales_enc"
    t.string   "estado_enc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "etapa_id"
    t.integer  "competencia_id"
    t.integer  "recinto_id"
    t.integer  "id_local"
    t.integer  "id_visita"
  end

  add_index "encuentros", ["competencia_id"], name: "index_encuentros_on_competencia_id", using: :btree
  add_index "encuentros", ["etapa_id"], name: "index_encuentros_on_etapa_id", using: :btree
  add_index "encuentros", ["recinto_id"], name: "index_encuentros_on_recinto_id", using: :btree

  create_table "equipos", force: true do |t|
    t.integer  "encuentro_id"
    t.integer  "convocatoria_id"
    t.string   "equ_citado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "equipos", ["convocatoria_id"], name: "index_equipos_on_convocatoria_id", using: :btree
  add_index "equipos", ["encuentro_id"], name: "index_equipos_on_encuentro_id", using: :btree

  create_table "etapas", force: true do |t|
    t.string   "nombre_etp"
    t.integer  "tipo_etp"
    t.integer  "competencia_id"
    t.integer  "etapa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "etapas", ["competencia_id"], name: "index_etapas_on_competencia_id", using: :btree
  add_index "etapas", ["etapa_id"], name: "index_etapas_on_etapa_id", using: :btree

  create_table "jugadors", force: true do |t|
    t.string   "nombre_jug"
    t.string   "apellido_pat_jug"
    t.string   "apellido_mat_jug"
    t.decimal  "rut_jug",          precision: 10, scale: 0
    t.boolean  "sexo_jug"
    t.date     "fecha_nac_jug"
    t.string   "email_jug"
    t.string   "foto_jug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizadors", force: true do |t|
    t.string   "nombre_org"
    t.string   "apellido_pat_org"
    t.string   "apellido_mat_org"
    t.decimal  "rut_org",          precision: 10, scale: 0
    t.boolean  "sexo_org"
    t.date     "fecha_nac_org"
    t.string   "email_org"
    t.string   "foto_org"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participante_competencia", force: true do |t|
    t.integer  "competencia_id"
    t.integer  "participante_id"
    t.integer  "enc_ganados_par_com"
    t.integer  "enc_perdidos_par_com"
    t.integer  "goles_favor_par_com"
    t.integer  "goles_contra_par_com"
    t.integer  "cant_tarjetas_amar_par_com"
    t.integer  "cant_tarjetas_roja_par_com"
    t.integer  "cant_puntos_par_com"
    t.integer  "cant_enc_jugados_par_com"
    t.integer  "grupo_par_com"
    t.integer  "total_enc_grupo_par_com"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "enc_empatados_par_com"
  end

  add_index "participante_competencia", ["competencia_id"], name: "index_participante_competencia_on_competencia_id", using: :btree
  add_index "participante_competencia", ["participante_id"], name: "index_participante_competencia_on_participante_id", using: :btree

  create_table "participantes", force: true do |t|
    t.string   "nombre_par"
    t.string   "pais_par"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recinto_competencia", force: true do |t|
    t.integer  "recinto_id"
    t.integer  "competencia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recinto_competencia", ["competencia_id"], name: "index_recinto_competencia_on_competencia_id", using: :btree
  add_index "recinto_competencia", ["recinto_id"], name: "index_recinto_competencia_on_recinto_id", using: :btree

  create_table "recintos", force: true do |t|
    t.string   "nombre_rec"
    t.string   "ciudad_rec"
    t.string   "pais_rec"
    t.integer  "capacidad_rec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rol_cuerpo_tecnicos", force: true do |t|
    t.integer  "rol_tecnico_id"
    t.integer  "participante_competencium_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tecnico_id"
  end

  add_index "rol_cuerpo_tecnicos", ["participante_competencium_id"], name: "index_rol_cuerpo_tecnicos_on_participante_competencium_id", using: :btree
  add_index "rol_cuerpo_tecnicos", ["rol_tecnico_id"], name: "index_rol_cuerpo_tecnicos_on_rol_tecnico_id", using: :btree
  add_index "rol_cuerpo_tecnicos", ["tecnico_id"], name: "index_rol_cuerpo_tecnicos_on_tecnico_id", using: :btree

  create_table "rol_tecnicos", force: true do |t|
    t.string   "tipo_rol_tec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tecnicos", force: true do |t|
    t.string   "nombre_tec"
    t.string   "apellido_pat_tec"
    t.string   "apellido_mat_tec"
    t.decimal  "rut_tec",          precision: 10, scale: 0
    t.boolean  "sexo_tec"
    t.date     "fecha_nac_tec"
    t.string   "email_tec"
    t.string   "foto_tec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
