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

ActiveRecord::Schema.define(version: 20160528055924) do

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                       null: false
    t.integer  "friend_id",  limit: 4,                       null: false
    t.string   "status",     limit: 255, default: "pending", null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "friendships", ["friend_id"], name: "fk_rails_cdd0bd9794", using: :btree
  add_index "friendships", ["user_id"], name: "fk_rails_3f42d39e3b", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                   null: false
    t.boolean  "public",     limit: 1,   default: false, null: false
    t.string   "latitude",   limit: 255,                 null: false
    t.string   "longitude",  limit: 255,                 null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "locations", ["user_id"], name: "fk_rails_08bcb71341", using: :btree

  create_table "shared_locations", force: :cascade do |t|
    t.integer  "location_id", limit: 4
    t.integer  "friend_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "shared_locations", ["friend_id"], name: "fk_rails_f7573d34a2", using: :btree
  add_index "shared_locations", ["location_id"], name: "fk_rails_3dee2d30bc", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "locations", "users"
  add_foreign_key "shared_locations", "locations"
  add_foreign_key "shared_locations", "users", column: "friend_id"
end
