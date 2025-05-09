ActiveRecord::Schema[8.0].define(version: 2025_04_29_010716) do
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "proponent_id", null: false
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_addresses_on_proponent_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "proponent_id", null: false
    t.integer "contact_type"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_contacts_on_proponent_id"
  end

  create_table "proponents", force: :cascade do |t|
    t.string "name"
    t.string "documents"
    t.date "birth_date"
    t.decimal "salary"
    t.decimal "inss_discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "proponents"
  add_foreign_key "contacts", "proponents"
end
