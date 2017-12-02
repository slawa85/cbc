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

ActiveRecord::Schema.define(version: 20171130133013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string   "code"
    t.integer  "panel_provider_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "countries", ["panel_provider_id"], name: "index_countries_on_panel_provider_id", using: :btree

  create_table "geo_targetings", force: :cascade do |t|
    t.integer "country_id"
    t.integer "target_group_id"
    t.boolean "target_group_root"
  end

  add_index "geo_targetings", ["country_id"], name: "index_geo_targetings_on_country_id", using: :btree
  add_index "geo_targetings", ["target_group_id"], name: "index_geo_targetings_on_target_group_id", using: :btree

  create_table "location_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.integer  "panel_provider_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "location_groups", ["country_id"], name: "index_location_groups_on_country_id", using: :btree
  add_index "location_groups", ["panel_provider_id"], name: "index_location_groups_on_panel_provider_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "secret_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "location_id"
    t.integer "location_group_id"
  end

  add_index "memberships", ["location_group_id"], name: "index_memberships_on_location_group_id", using: :btree
  add_index "memberships", ["location_id"], name: "index_memberships_on_location_id", using: :btree

  create_table "panel_providers", force: :cascade do |t|
    t.string   "code"
    t.string   "parser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "secret_code"
    t.integer  "panel_provider_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "target_groups", ["panel_provider_id"], name: "index_target_groups_on_panel_provider_id", using: :btree
  add_index "target_groups", ["parent_id"], name: "index_target_groups_on_parent_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "countries", "panel_providers"
  add_foreign_key "geo_targetings", "countries"
  add_foreign_key "geo_targetings", "target_groups"
  add_foreign_key "location_groups", "countries"
  add_foreign_key "location_groups", "panel_providers"
  add_foreign_key "memberships", "location_groups"
  add_foreign_key "memberships", "locations"
  add_foreign_key "target_groups", "panel_providers"
end
