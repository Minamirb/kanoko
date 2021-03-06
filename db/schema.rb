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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120512175439) do

  create_table "accounts", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "screen_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
  end

  create_table "articles", :force => true do |t|
    t.text     "content"
    t.integer  "member_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.binary   "picture"
    t.integer  "user_id"
    t.integer  "diary_id"
  end

  add_index "articles", ["member_id"], :name => "index_articles_on_member_id"

  create_table "diaries", :force => true do |t|
    t.string   "title"
    t.boolean  "deliver"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "baton"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "diary_id"
    t.integer  "sort"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "confirm",      :default => false
    t.string   "confirm_hash"
  end

  add_index "members", ["diary_id"], :name => "index_members_on_diary_id"
  add_index "members", ["user_id"], :name => "index_members_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
