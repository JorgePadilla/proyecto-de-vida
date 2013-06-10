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

ActiveRecord::Schema.define(:version => 20130610192501) do

  create_table "asesors", :force => true do |t|
    t.string   "nombre"
    t.string   "identidad"
    t.integer  "moderador_id"
    t.float    "comision_credito"
    t.float    "comision_contado_empresa"
    t.float    "comision_contado_asesor"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "coordinadors", :force => true do |t|
    t.string   "nombre"
    t.integer  "director_comercial_id"
    t.float    "comision_credito"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "cuota", :force => true do |t|
    t.string   "estado"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.date     "fecha"
    t.float    "valor"
    t.float    "valor_credito"
    t.float    "valor_deposito"
    t.float    "mora"
    t.float    "descuento"
    t.float    "saldo"
    t.string   "num_deposito"
    t.integer  "usuario_id"
    t.boolean  "revisado"
    t.text     "observaciones"
    t.integer  "num_cuota"
    t.integer  "pedido_id"
    t.boolean  "liquidado"
  end

  create_table "depositos", :force => true do |t|
    t.string   "numero"
    t.date     "fecha"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "director_comercials", :force => true do |t|
    t.string   "nombre"
    t.integer  "gerente_comercial_id"
    t.float    "comision_credito"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "entrada_inventarios", :force => true do |t|
    t.string   "numero"
    t.date     "fecha"
    t.integer  "inventario_id"
    t.string   "proveedor"
    t.integer  "cantidad"
    t.float    "valor_unitario"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.float    "valor_unitario_dolares"
  end

  create_table "gerente_comercials", :force => true do |t|
    t.string   "nombre"
    t.float    "comision_credito"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "inventarios", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "liquidacion_comisions", :force => true do |t|
    t.integer  "empleado_id"
    t.string   "rol"
    t.date     "fecha"
    t.integer  "monto"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "fecha_inicio"
    t.date     "fecha_final"
  end

  create_table "moderadors", :force => true do |t|
    t.string   "nombre"
    t.integer  "coordinador_id"
    t.float    "comision_credito"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "nota_devolucions", :force => true do |t|
    t.date     "fecha"
    t.string   "numero"
    t.integer  "transito_id"
    t.integer  "cantidad"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "nota_entregas", :force => true do |t|
    t.date     "fecha"
    t.string   "numero"
    t.integer  "transito_id"
    t.integer  "cantidad"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pago_cuota", :force => true do |t|
    t.date     "fecha"
    t.string   "numero_deposito"
    t.decimal  "monto"
    t.boolean  "revisado"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "cuotum_id"
  end

  create_table "pedidos", :force => true do |t|
    t.integer  "asesor_id"
    t.string   "evento"
    t.string   "ciudad"
    t.date     "fecha_evento"
    t.string   "nombre_cliente"
    t.string   "identidad_cliente"
    t.string   "telefono_cliente"
    t.string   "celular_cliente"
    t.string   "correo_electronico"
    t.string   "direccion_cliente"
    t.string   "ciudad_cliente"
    t.string   "departamento_cliente"
    t.string   "trabajo_cliente"
    t.string   "cargo_cliente"
    t.string   "telefono_trabajo"
    t.time     "inicio_hora_contacto"
    t.time     "fin_hora_contacto"
    t.string   "conyugue"
    t.string   "referencia"
    t.string   "telefono_referencia"
    t.string   "alumno"
    t.string   "grado"
    t.string   "jornada"
    t.float    "valor_credito"
    t.float    "abono_inicial"
    t.integer  "numero_cuotas"
    t.float    "valor_cuota"
    t.date     "fecha_inicio_pago"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "numero_pedido"
    t.string   "telefono_conyugue"
    t.string   "referencia2"
    t.string   "telefono_referencia2"
    t.float    "descuento"
    t.float    "mora"
    t.string   "tipo_pago"
    t.date     "fecha_ingreso"
    t.integer  "num_dias_descuento"
    t.string   "rvi"
    t.integer  "dias_mora"
    t.string   "estado_pedido"
    t.text     "observaciones"
    t.boolean  "liquidado_asesor"
    t.boolean  "liquidado_moderador"
    t.boolean  "liquidado_coordinador"
    t.boolean  "liquidado_director_comercial"
    t.boolean  "liquidado_gerente_comercial"
    t.date     "fecha_deposito_abono_inicial"
    t.string   "numero_deposito_abono_inicial"
    t.boolean  "revisado_abono_inicial"
  end

  create_table "permisos", :force => true do |t|
    t.string   "acesso"
    t.string   "tipo_acesso"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "permisos_por_rols", :force => true do |t|
    t.integer  "rol_id"
    t.integer  "permiso_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "producto_ingresos", :force => true do |t|
    t.integer  "producto_id"
    t.date     "fecha_ingreso"
    t.string   "documento_ingreso"
    t.integer  "cantidad_ingreso"
    t.float    "valor_producto"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "producto_pedidos", :force => true do |t|
    t.integer  "producto_id"
    t.integer  "pedido_id"
    t.integer  "cantidad"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "productos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rols", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transitos", :force => true do |t|
    t.integer  "asesor_id"
    t.integer  "cantidad"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "inventario_id"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "rol_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "usuarios", ["rol_id"], :name => "index_usuarios_on_rol_id"

end
