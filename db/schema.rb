# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160817210827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "fundings", force: :cascade do |t|
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.decimal  "total_price"
    t.integer  "user_id"
    t.string   "status",      default: "awaiting payment"
  end

  add_index "fundings", ["user_id"], name: "index_fundings_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "status",      default: 0
    t.text     "description"
  end

  create_table "recipient_fundings", id: false, force: :cascade do |t|
    t.decimal "microloan_amount"
    t.integer "recipient_id"
    t.integer "funding_id"
  end

  add_index "recipient_fundings", ["funding_id"], name: "index_recipient_fundings_on_funding_id", using: :btree
  add_index "recipient_fundings", ["recipient_id"], name: "index_recipient_fundings_on_recipient_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.string   "name"
    t.decimal  "amount_received"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "description"
    t.string   "image_path"
    t.integer  "organization_id"
    t.integer  "country_id"
  end

  add_index "recipients", ["country_id"], name: "index_recipients_on_country_id", using: :btree
  add_index "recipients", ["organization_id"], name: "index_recipients_on_organization_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
    t.integer  "organization_id"
  end

  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree

  add_foreign_key "fundings", "users"
  add_foreign_key "recipient_fundings", "fundings"
  add_foreign_key "recipient_fundings", "recipients"
  add_foreign_key "recipients", "countries"
  add_foreign_key "recipients", "organizations"
  add_foreign_key "users", "organizations"
end
