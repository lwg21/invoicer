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

ActiveRecord::Schema[8.0].define(version: 2025_03_05_190904) do
  create_table "clients", force: :cascade do |t|
    t.string "details"
    t.string "vat_number"
    t.string "phone_number"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "companies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "vat_number"
    t.string "phone_number"
    t.string "email_address"
    t.string "iban"
    t.string "bic"
    t.string "jurisdiction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "details"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.string "name"
    t.string "description"
    t.date "date"
    t.integer "quantity"
    t.decimal "unit_price"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "number"
    t.date "date"
    t.boolean "issued", default: false, null: false
    t.boolean "paid", default: false, null: false
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id", null: false
    t.string "client_details"
    t.string "client_vat_number"
    t.string "company_vat_number"
    t.string "company_phone_number"
    t.string "company_email_address"
    t.string "company_iban"
    t.string "company_bic"
    t.string "company_jurisdiction"
    t.string "company_details"
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["company_id"], name: "index_invoices_on_company_id"
  end

  create_table "mentions", force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.integer "position"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_mentions_on_invoice_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "companies", "users"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoices", "clients"
  add_foreign_key "invoices", "companies"
  add_foreign_key "mentions", "invoices"
  add_foreign_key "sessions", "users"
end
