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

ActiveRecord::Schema[8.0].define(version: 2025_01_08_095101) do
  create_table "clients", force: :cascade do |t|
    t.string "designation"
    t.string "address_line1"
    t.string "address_line2"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.string "vat_number"
    t.string "phone_number"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer "invoice_id"
    t.string "name"
    t.string "description"
    t.date "date"
    t.integer "quantity"
    t.decimal "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "number"
    t.string "date"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
  end
end
