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

ActiveRecord::Schema.define(version: 20170828121641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blacklists", force: :cascade do |t|
    t.string   "Player_name"
    t.boolean  "character_type"
    t.integer  "tag"
    t.string   "reason"
    t.integer  "reporter_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "standing",   null: false
    t.datetime "expire?"
    t.string   "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "category",        null: false
    t.boolean  "is_admin"
    t.boolean  "is_chat_group"
    t.string   "chat_group_name"
    t.string   "note"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "is_hidden"
    t.boolean  "is_director"
  end

  create_table "logs", force: :cascade do |t|
    t.string   "table"
    t.string   "event"
    t.string   "details"
    t.string   "task_length"
    t.integer  "event_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "group_id",   null: false
    t.boolean  "approved",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.string   "contents"
    t.boolean  "removed?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "srp_requests", force: :cascade do |t|
    t.string   "link",        null: false
    t.integer  "user_id",     null: false
    t.string   "user_name",   null: false
    t.string   "ship",        null: false
    t.string   "user_notes"
    t.boolean  "insured?"
    t.integer  "status"
    t.integer  "payment_id"
    t.integer  "SRP_amount"
    t.string   "admin_notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "timesheets", force: :cascade do |t|
    t.string   "event"
    t.datetime "event_time"
    t.integer  "user_id"
    t.integer  "urgency"
    t.string   "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "event_type"
    t.integer  "event_group"
    t.boolean  "broadcast"
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.integer  "topic_id"
    t.string   "title",          null: false
    t.string   "description"
    t.boolean  "group_required"
    t.integer  "group_type"
    t.boolean  "allow_topics"
    t.boolean  "allow_posts"
    t.integer  "rank"
    t.boolean  "active"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "key_id"
    t.string   "v_code"
    t.string   "encrypted_v_code"
    t.integer  "primary_character"
    t.integer  "primary_character_id"
    t.string   "primary_character_name"
    t.boolean  "valid_api",              default: false, null: false
    t.boolean  "admin",                  default: false
    t.string   "primary_timezone"
    t.datetime "character_cake_day"
    t.string   "discord_user_id"
    t.boolean  "director",               default: false
    t.string   "corp_ticker"
    t.string   "discord_invite"
    t.boolean  "discord_connected"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
