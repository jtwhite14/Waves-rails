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

ActiveRecord::Schema.define(version: 20150122145105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buoys", force: true do |t|
    t.string   "name"
    t.string   "external_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                  default: ""
    t.string   "description",            default: ""
    t.string   "station_id"
    t.integer  "current_observation_id"
    t.integer  "tidal_buoy_id"
  end

  add_index "buoys", ["tidal_buoy_id"], name: "index_buoys_on_tidal_buoy_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "observations", force: true do |t|
    t.datetime "timestamp"
    t.integer  "buoy_id"
    t.float    "wave_height"
    t.float    "swell_height"
    t.float    "swell_period"
    t.float    "wind_wave_height"
    t.float    "wind_wave_period"
    t.string   "swell_direction"
    t.string   "steepness"
    t.float    "average_wave_period"
    t.integer  "mean_wave_direction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "wind_speed"
    t.float    "wind_gusts"
    t.string   "wind_direction"
    t.integer  "mean_wind_direction"
    t.float    "air_temp"
    t.float    "water_temp"
    t.float    "log_tide_value"
    t.datetime "log_time_timestamp"
    t.float    "first_low_value"
    t.datetime "first_low_timestamp"
    t.float    "second_low_value"
    t.datetime "second_low_timestamp"
    t.float    "first_high_value"
    t.datetime "first_high_timestamp"
    t.float    "second_high_value"
    t.float    "second_high_timestamp"
    t.integer  "wind_degrees"
  end

  add_index "observations", ["buoy_id"], name: "index_observations_on_buoy_id", using: :btree
  add_index "observations", ["timestamp"], name: "index_observations_on_timestamp", using: :btree

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.integer  "wave_id"
    t.text     "notes"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "observation_id"
    t.string   "session_photo"
    t.datetime "timestamp"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "finalized",         default: false
    t.string   "session_photo_tmp"
    t.string   "guid"
  end

  add_index "sessions", ["guid"], name: "index_sessions_on_guid", using: :btree
  add_index "sessions", ["observation_id"], name: "index_sessions_on_observation_id", using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree
  add_index "sessions", ["wave_id"], name: "index_sessions_on_wave_id", using: :btree

  create_table "tidal_buoys", force: true do |t|
    t.string   "title"
    t.string   "station_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: false
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.string   "name"
    t.string   "avatar"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "waves", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "buoy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "state"
    t.string   "address"
    t.string   "slug"
    t.integer  "sessions_count", default: 0
  end

  add_index "waves", ["buoy_id"], name: "index_waves_on_buoy_id", using: :btree
  add_index "waves", ["latitude"], name: "index_waves_on_latitude", using: :btree
  add_index "waves", ["longitude"], name: "index_waves_on_longitude", using: :btree
  add_index "waves", ["slug"], name: "index_waves_on_slug", using: :btree
  add_index "waves", ["user_id"], name: "index_waves_on_user_id", using: :btree

end
