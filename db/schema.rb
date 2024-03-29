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

ActiveRecord::Schema.define(:version => 20111020214253) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "games", :force => true do |t|
    t.string   "state"
    t.integer  "participations_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deployment_finish_at"
    t.integer  "active_participation_id"
    t.datetime "turn_finish_at"
    t.integer  "turn",                    :default => 0
  end

  create_table "neighbourhoods", :force => true do |t|
    t.integer  "territory_id"
    t.integer  "other_territory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ownerships", :force => true do |t|
    t.integer  "territory_id"
    t.integer  "participation_id"
    t.integer  "game_id"
    t.integer  "units_count",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "color"
    t.boolean  "alive",       :default => false
    t.integer  "units_count", :default => 0
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "territories", :force => true do |t|
    t.text     "path"
    t.integer  "badge_offset_x"
    t.integer  "badge_offset_y"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
