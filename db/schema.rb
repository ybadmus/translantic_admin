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

ActiveRecord::Schema[7.0].define(version: 2023_12_29_142953) do
  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.bigint "location_id", null: false
    t.string "phone"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_customers_on_location_id"
  end

  create_table "incoterms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "abbr", limit: 3, null: false
    t.string "description", null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "city", null: false
    t.string "state", default: ""
    t.string "zip_code", limit: 5, default: ""
    t.string "country", null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "frieght_type", limit: 1, default: 1, null: false
    t.integer "status", limit: 1, default: 1, null: false
    t.bigint "departure_id", null: false
    t.bigint "destination_id", null: false
    t.bigint "incoterm_id", null: false
    t.decimal "total_gross_weight", precision: 5, scale: 3, default: "0.0", null: false
    t.decimal "length", precision: 5, scale: 3, default: "0.0", null: false
    t.decimal "width", precision: 5, scale: 3, default: "0.0", null: false
    t.decimal "height", precision: 5, scale: 3, default: "0.0", null: false
    t.text "message", null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departure_id"], name: "index_quotes_on_departure_id"
    t.index ["destination_id"], name: "index_quotes_on_destination_id"
    t.index ["incoterm_id"], name: "index_quotes_on_incoterm_id"
  end

  create_table "shipping_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "frieght_type", limit: 1, default: 1, null: false
    t.decimal "length", precision: 5, scale: 3, default: "0.0", null: false
    t.decimal "height", precision: 5, scale: 3, default: "0.0", null: false
    t.decimal "width", precision: 5, scale: 3, default: "0.0", null: false
    t.text "description", null: false
    t.boolean "dutiable", default: false
    t.decimal "weight", precision: 5, scale: 3, default: "0.0", null: false
    t.integer "quantity", default: 0
    t.bigint "current_location_id", null: false
    t.bigint "customer_id", null: false
    t.bigint "incoterm_id", null: false
    t.bigint "departure_id", null: false
    t.bigint "shipping_information_id", null: false
    t.decimal "declared_value", precision: 5, scale: 3, default: "0.0", null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_location_id"], name: "index_shipping_details_on_current_location_id"
    t.index ["customer_id"], name: "index_shipping_details_on_customer_id"
    t.index ["departure_id"], name: "index_shipping_details_on_departure_id"
    t.index ["incoterm_id"], name: "index_shipping_details_on_incoterm_id"
    t.index ["shipping_information_id"], name: "index_shipping_details_on_shipping_information_id"
  end

  create_table "shipping_informations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "company_name"
    t.string "address_line1", null: false
    t.string "address_line2"
    t.bigint "location_id", null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_shipping_informations_on_customer_id"
    t.index ["location_id"], name: "index_shipping_informations_on_location_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "quotes", "locations", column: "departure_id"
  add_foreign_key "quotes", "locations", column: "destination_id"
  add_foreign_key "shipping_details", "locations", column: "current_location_id"
  add_foreign_key "shipping_details", "locations", column: "departure_id"
end
