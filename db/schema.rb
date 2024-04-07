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

ActiveRecord::Schema[7.1].define(version: 2024_03_28_023311) do
  create_table "audits", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "phone"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enquiries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "subject", null: false
    t.text "message", null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "code", limit: 5, default: ""
    t.string "country", default: ""
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_locations_on_city", unique: true
  end

  create_table "quotes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "frieght_type", limit: 1, default: 1, null: false
    t.integer "status", limit: 1, default: 1
    t.bigint "departure_id", null: false
    t.bigint "destination_id", null: false
    t.bigint "incoterm_id", null: false
    t.bigint "quoter_id", null: false
    t.decimal "total_gross_weight", precision: 5, scale: 2, null: false
    t.decimal "length", precision: 5, scale: 2, null: false
    t.decimal "width", precision: 5, scale: 2, null: false
    t.decimal "height", precision: 5, scale: 2, null: false
    t.text "message", null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departure_id"], name: "index_quotes_on_departure_id"
    t.index ["destination_id"], name: "index_quotes_on_destination_id"
    t.index ["incoterm_id"], name: "index_quotes_on_incoterm_id"
    t.index ["quoter_id"], name: "index_quotes_on_quoter_id"
  end

  create_table "shipping_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "frieght_type", limit: 1, default: 1
    t.decimal "length", precision: 5, scale: 2, null: false
    t.decimal "height", precision: 5, scale: 2, null: false
    t.decimal "width", precision: 5, scale: 2, null: false
    t.integer "status", limit: 1, default: 1
    t.string "tracking_number", limit: 14, null: false
    t.string "description", limit: 500, null: false
    t.boolean "dutiable", default: false
    t.decimal "weight", precision: 5, scale: 2, null: false
    t.integer "quantity", default: 1
    t.bigint "location_id"
    t.bigint "shipper_id", null: false
    t.bigint "receiver_id", null: false
    t.bigint "incoterm_id", null: false
    t.bigint "departure_id", null: false
    t.bigint "destination_id", null: false
    t.bigint "shipping_information_id", null: false
    t.decimal "declared_value", precision: 10, scale: 2, null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departure_id"], name: "index_shipping_details_on_departure_id"
    t.index ["destination_id"], name: "index_shipping_details_on_destination_id"
    t.index ["incoterm_id"], name: "index_shipping_details_on_incoterm_id"
    t.index ["location_id"], name: "index_shipping_details_on_location_id"
    t.index ["receiver_id"], name: "index_shipping_details_on_receiver_id"
    t.index ["shipper_id"], name: "index_shipping_details_on_shipper_id"
    t.index ["shipping_information_id"], name: "index_shipping_details_on_shipping_information_id"
  end

  create_table "shipping_informations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "company_name"
    t.string "address_line1", null: false
    t.string "address_line2"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "quotes", "customers", column: "quoter_id"
  add_foreign_key "quotes", "locations", column: "departure_id"
  add_foreign_key "quotes", "locations", column: "destination_id"
  add_foreign_key "shipping_details", "customers", column: "receiver_id"
  add_foreign_key "shipping_details", "customers", column: "shipper_id"
  add_foreign_key "shipping_details", "locations", column: "departure_id"
  add_foreign_key "shipping_details", "locations", column: "destination_id"
end
