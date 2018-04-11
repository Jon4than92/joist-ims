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

ActiveRecord::Schema.define(version: 12) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_types", force: :cascade do |t|
    t.string "name", limit: 25, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_account_types_on_name", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "account_type_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["employee_id"], name: "index_accounts_on_employee_id"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "buildings", force: :cascade do |t|
    t.string "name", limit: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_buildings_on_created_by_id"
    t.index ["name"], name: "index_buildings_on_name", unique: true
    t.index ["updated_by_id"], name: "index_buildings_on_updated_by_id"
  end

  create_table "custodian_accounts", force: :cascade do |t|
    t.string "name", limit: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_custodian_accounts_on_created_by_id"
    t.index ["name"], name: "index_custodian_accounts_on_name", unique: true
    t.index ["updated_by_id"], name: "index_custodian_accounts_on_updated_by_id"
  end

  create_table "custodians", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "custodian_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_custodians_on_created_by_id"
    t.index ["custodian_account_id"], name: "index_custodians_on_custodian_account_id"
    t.index ["employee_id"], name: "index_custodians_on_employee_id"
    t.index ["updated_by_id"], name: "index_custodians_on_updated_by_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name", limit: 25, null: false
    t.string "middle_initial", limit: 1
    t.string "last_name", limit: 25, null: false
    t.string "job_title", limit: 50, null: false
    t.bigint "room_id", null: false
    t.string "email", limit: 75, null: false
    t.string "phone", limit: 15, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_employees_on_created_by_id"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["room_id"], name: "index_employees_on_room_id"
    t.index ["updated_by_id"], name: "index_employees_on_updated_by_id"
  end

  create_table "hardware", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.bigint "manufacturer_id", null: false
    t.integer "year", null: false
    t.string "model_num", limit: 50, null: false
    t.string "tag_num", limit: 50, null: false
    t.string "serial_num", limit: 50, null: false
    t.decimal "cost", precision: 10, scale: 2, null: false
    t.string "condition", limit: 25, null: false
    t.text "notes"
    t.bigint "room_id", null: false
    t.date "assigned_date"
    t.bigint "custodian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assigned_to_id"
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["assigned_to_id"], name: "index_hardware_on_assigned_to_id"
    t.index ["created_by_id"], name: "index_hardware_on_created_by_id"
    t.index ["custodian_id"], name: "index_hardware_on_custodian_id"
    t.index ["manufacturer_id"], name: "index_hardware_on_manufacturer_id"
    t.index ["room_id"], name: "index_hardware_on_room_id"
    t.index ["serial_num"], name: "index_hardware_on_serial_num", unique: true
    t.index ["tag_num"], name: "index_hardware_on_tag_num", unique: true
    t.index ["updated_by_id"], name: "index_hardware_on_updated_by_id"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_manufacturers_on_created_by_id"
    t.index ["name"], name: "index_manufacturers_on_name", unique: true
    t.index ["updated_by_id"], name: "index_manufacturers_on_updated_by_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "building_id", null: false
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["building_id"], name: "index_rooms_on_building_id"
    t.index ["created_by_id"], name: "index_rooms_on_created_by_id"
    t.index ["updated_by_id"], name: "index_rooms_on_updated_by_id"
  end

  create_table "software", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.bigint "vendor_id", null: false
    t.string "version", limit: 50, null: false
    t.integer "year", null: false
    t.date "assigned_date"
    t.date "license_start_date"
    t.date "license_end_date"
    t.boolean "active", default: true, null: false
    t.decimal "cost", precision: 10, scale: 2, null: false
    t.string "license_key", limit: 50, null: false
    t.bigint "hardware_id"
    t.bigint "custodian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assigned_to_id"
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["assigned_to_id"], name: "index_software_on_assigned_to_id"
    t.index ["created_by_id"], name: "index_software_on_created_by_id"
    t.index ["custodian_id"], name: "index_software_on_custodian_id"
    t.index ["hardware_id"], name: "index_software_on_hardware_id"
    t.index ["updated_by_id"], name: "index_software_on_updated_by_id"
    t.index ["vendor_id"], name: "index_software_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "updated_by_id"
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_vendors_on_created_by_id"
    t.index ["name"], name: "index_vendors_on_name", unique: true
    t.index ["updated_by_id"], name: "index_vendors_on_updated_by_id"
  end

  add_foreign_key "accounts", "account_types", on_update: :cascade, on_delete: :restrict
  add_foreign_key "accounts", "employees", on_update: :cascade, on_delete: :cascade
  add_foreign_key "buildings", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "buildings", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "custodian_accounts", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "custodian_accounts", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "custodians", "custodian_accounts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "custodians", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "custodians", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "custodians", "employees", on_update: :cascade, on_delete: :cascade
  add_foreign_key "employees", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "employees", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "employees", "rooms", on_update: :cascade, on_delete: :restrict
  add_foreign_key "hardware", "custodians", on_update: :cascade, on_delete: :nullify
  add_foreign_key "hardware", "employees", column: "assigned_to_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "hardware", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "hardware", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "hardware", "manufacturers", on_update: :cascade, on_delete: :restrict
  add_foreign_key "hardware", "rooms", on_update: :cascade, on_delete: :nullify
  add_foreign_key "manufacturers", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "manufacturers", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "rooms", "buildings", on_update: :cascade, on_delete: :cascade
  add_foreign_key "rooms", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "rooms", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "custodians", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "employees", column: "assigned_to_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "hardware", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "vendors", on_update: :cascade, on_delete: :restrict
  add_foreign_key "vendors", "employees", column: "created_by_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "vendors", "employees", column: "updated_by_id", on_update: :cascade, on_delete: :nullify
end
