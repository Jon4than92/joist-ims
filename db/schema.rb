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

ActiveRecord::Schema.define(version: 11) do

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
    t.string "email", limit: 75, null: false
    t.string "password", limit: 75, null: false
    t.bigint "account_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["employee_id"], name: "index_accounts_on_employee_id"
  end

  create_table "buildings", force: :cascade do |t|
    t.string "name", limit: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_buildings_on_name", unique: true
  end

  create_table "custodian_accounts", force: :cascade do |t|
    t.string "name", limit: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_custodian_accounts_on_name", unique: true
  end

  create_table "custodians", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "custodian_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custodian_account_id"], name: "index_custodians_on_custodian_account_id"
    t.index ["employee_id"], name: "index_custodians_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "firstName", limit: 25, null: false
    t.string "middleInitial", limit: 1, null: false
    t.string "lastName", limit: 25, null: false
    t.string "jobTitle", limit: 50, null: false
    t.bigint "location_id", null: false
    t.string "email", limit: 75, null: false
    t.string "phone", limit: 15, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["location_id"], name: "index_employees_on_location_id"
  end

  create_table "hardware", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.bigint "manufacturer_id", null: false
    t.integer "year", null: false
    t.string "modelNum", limit: 50, null: false
    t.integer "tagNum", null: false
    t.string "serialNum", limit: 50, null: false
    t.decimal "cost", precision: 2, null: false
    t.string "condition", limit: 25, null: false
    t.text "notes"
    t.bigint "location_id"
    t.bigint "assignedTo_id"
    t.date "assignedDate"
    t.bigint "custodian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignedTo_id"], name: "index_hardware_on_assignedTo_id"
    t.index ["custodian_id"], name: "index_hardware_on_custodian_id"
    t.index ["location_id"], name: "index_hardware_on_location_id"
    t.index ["manufacturer_id"], name: "index_hardware_on_manufacturer_id"
    t.index ["serialNum"], name: "index_hardware_on_serialNum", unique: true
    t.index ["tagNum"], name: "index_hardware_on_tagNum", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "building_id", null: false
    t.string "room", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_locations_on_building_id"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_manufacturers_on_name", unique: true
  end

  create_table "software", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.bigint "vendor_id", null: false
    t.string "version", limit: 50, null: false
    t.integer "year", null: false
    t.bigint "assignedTo_id"
    t.date "assignedDate"
    t.bigint "hardware_id"
    t.bigint "custodian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignedTo_id"], name: "index_software_on_assignedTo_id"
    t.index ["custodian_id"], name: "index_software_on_custodian_id"
    t.index ["hardware_id"], name: "index_software_on_hardware_id"
    t.index ["vendor_id"], name: "index_software_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name", limit: 75, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_vendors_on_name", unique: true
  end

  add_foreign_key "accounts", "account_types"
  add_foreign_key "accounts", "employees", on_update: :cascade, on_delete: :cascade
  add_foreign_key "custodians", "custodian_accounts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "custodians", "employees", on_update: :cascade, on_delete: :cascade
  add_foreign_key "employees", "locations", on_update: :cascade, on_delete: :restrict
  add_foreign_key "hardware", "custodians", on_update: :cascade, on_delete: :nullify
  add_foreign_key "hardware", "employees", column: "assignedTo_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "hardware", "locations", on_update: :cascade, on_delete: :nullify
  add_foreign_key "hardware", "manufacturers", on_update: :cascade, on_delete: :restrict
  add_foreign_key "locations", "buildings", on_update: :cascade, on_delete: :cascade
  add_foreign_key "software", "custodians", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "employees", column: "assignedTo_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "hardware", on_update: :cascade, on_delete: :nullify
  add_foreign_key "software", "vendors"
end
