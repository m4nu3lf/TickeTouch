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

ActiveRecord::Schema.define(:version => 20130616085916) do

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "art_name"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "purchases", :force => true do |t|
    t.integer  "user_id"
    t.datetime "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pay_type"
    t.float    "total_price"
  end

  add_index "purchases", ["user_id"], :name => "index_purchases_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sites", :force => true do |t|
    t.string   "address"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "city"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "stages", :force => true do |t|
    t.integer  "event_id"
    t.integer  "site_id"
    t.datetime "date_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stages", ["event_id"], :name => "index_stages_on_event_id"
  add_index "stages", ["site_id"], :name => "index_stages_on_site_id"

  create_table "ticket_types", :force => true do |t|
    t.decimal  "price",        :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stage_id"
    t.integer  "availability"
    t.string   "description"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "ticket_type_id"
    t.integer  "purchase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.string   "key_code"
  end

  add_index "tickets", ["purchase_id"], :name => "index_tickets_on_purchase_id"
  add_index "tickets", ["ticket_type_id"], :name => "index_tickets_on_ticket_type_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.string   "surname"
    t.string   "address"
    t.string   "tel_number"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_password"
    t.string   "salt"
  end

end
