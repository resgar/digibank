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

ActiveRecord::Schema.define(version: 2021_08_07_174522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "account_password_hashes", force: :cascade do |t|
    t.string "password_hash", null: false
  end

  create_table "account_remember_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.citext "email", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.float "balance", default: 0.0, null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_bank_accounts_on_account_id", unique: true
  end

  create_table "bank_transactions", force: :cascade do |t|
    t.float "amount"
    t.integer "status", limit: 2, default: 0
    t.bigint "bank_account_id", null: false
    t.bigint "output_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_account_id"], name: "index_bank_transactions_on_bank_account_id"
    t.index ["output_id"], name: "index_bank_transactions_on_output_id"
  end

  create_table "idempotent_models", force: :cascade do |t|
    t.string "key"
    t.string "retriable_type"
    t.bigint "retriable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["retriable_type", "retriable_id"], name: "index_idempotent_models_on_retriable"
  end

  add_foreign_key "account_password_hashes", "accounts", column: "id"
  add_foreign_key "account_remember_keys", "accounts", column: "id"
  add_foreign_key "bank_accounts", "accounts"
  add_foreign_key "bank_transactions", "bank_accounts"
  add_foreign_key "bank_transactions", "bank_accounts", column: "output_id"
end
