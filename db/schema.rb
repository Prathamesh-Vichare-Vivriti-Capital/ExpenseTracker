# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_17_122851) do

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bills", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "invoice_number"
    t.float "amount"
    t.date "date"
    t.text "description"
    t.string "status"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", null: false
    t.string "name", default: "", null: false
    t.string "employment_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id"
    t.index ["admin_id"], name: "index_users_on_admin_id"
  end

  add_foreign_key "bills", "users"
  add_foreign_key "users", "admins"
end
