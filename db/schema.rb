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

ActiveRecord::Schema.define(:version => 20121026011812) do

  create_table "amenities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "park_amenities", :force => true do |t|
    t.integer  "park_id"
    t.integer  "amenity_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parks", :force => true do |t|
    t.string   "name"
    t.text     "history"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "contact_info"
    t.float    "park_size"
    t.text     "address"
    t.string   "vimeo_embed"
    t.string   "flicker_pool"
    t.string   "section"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
