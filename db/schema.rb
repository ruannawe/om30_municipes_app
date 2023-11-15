# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_15_192412) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "citizen_id", null: false
    t.string "zip_code"
    t.string "street"
    t.string "complement"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "ibge_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citizen_id"], name: "index_addresses_on_citizen_id"
    t.index ["city"], name: "index_addresses_on_city"
    t.index ["ibge_code"], name: "index_addresses_on_ibge_code"
    t.index ["neighborhood"], name: "index_addresses_on_neighborhood"
    t.index ["state"], name: "index_addresses_on_state"
    t.index ["street"], name: "index_addresses_on_street"
    t.index ["zip_code"], name: "index_addresses_on_zip_code"
  end

  create_table "citizens", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "tax_id", null: false
    t.string "national_health_card", null: false
    t.string "email", null: false
    t.date "birthdate", null: false
    t.string "phone", null: false
    t.string "photo"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birthdate"], name: "index_citizens_on_birthdate"
    t.index ["email"], name: "index_citizens_on_email", unique: true
    t.index ["full_name"], name: "index_citizens_on_full_name"
    t.index ["national_health_card"], name: "index_citizens_on_national_health_card"
    t.index ["phone"], name: "index_citizens_on_phone"
    t.index ["tax_id"], name: "index_citizens_on_tax_id", unique: true
  end

  add_foreign_key "addresses", "citizens"
end
