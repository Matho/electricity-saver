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

ActiveRecord::Schema[7.0].define(version: 2022_12_27_074855) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_states", force: :cascade do |t|
    t.string "state", null: false
    t.integer "smart_plug_device_id", null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_current_states_on_created_at"
    t.index ["network_id"], name: "index_current_states_on_network_id"
    t.index ["updated_at"], name: "index_current_states_on_updated_at"
  end

  create_table "endpoint_devices", force: :cascade do |t|
    t.string "title", null: false
    t.string "gps_position"
    t.text "description"
    t.string "ip_address"
    t.string "contact_info"
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_monitoring", default: true
    t.index ["network_id"], name: "index_endpoint_devices_on_network_id"
  end

  create_table "event_logs", force: :cascade do |t|
    t.datetime "event_date", precision: nil, null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", null: false
    t.integer "event_loggable_id", null: false
    t.string "event_loggable_type", null: false
    t.index ["event_loggable_type", "event_loggable_id"], name: "index_event_logs_on_event_loggable_type_and_event_loggable_id"
    t.index ["network_id"], name: "index_event_logs_on_network_id"
  end

  create_table "networks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ping_stats", force: :cascade do |t|
    t.string "ip_address", null: false
    t.integer "response_time"
    t.string "response_code"
    t.string "response_status", null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_id"], name: "index_ping_stats_on_network_id"
  end

  create_table "rules", force: :cascade do |t|
    t.string "rule", null: false
    t.integer "smart_plug_device_id", null: false
    t.string "action", null: false
    t.string "cron_monday"
    t.string "cron_tuesday"
    t.string "cron_wednesday"
    t.string "cron_thursday"
    t.string "cron_friday"
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cron_saturday"
    t.string "cron_sunday"
    t.index ["action", "smart_plug_device_id"], name: "index_rules_on_action_and_smart_plug_device_id", unique: true
    t.index ["network_id"], name: "index_rules_on_network_id"
  end

  create_table "saved_energies", force: :cascade do |t|
    t.integer "smart_plug_device_id", null: false
    t.integer "savings"
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "day", null: false
    t.decimal "total_energy_price"
    t.decimal "powered_on_hours"
    t.decimal "powered_off_hours"
    t.index ["network_id"], name: "index_saved_energies_on_network_id"
  end

  create_table "scheduled_events", force: :cascade do |t|
    t.datetime "event_date", precision: nil, null: false
    t.integer "smart_plug_device_id", null: false
    t.string "action", null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "0", null: false
    t.text "reason"
    t.index ["network_id"], name: "index_scheduled_events_on_network_id"
  end

  create_table "smart_plug_devices", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "api_title", null: false
    t.string "api_status_url", null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "current_state", default: "2", null: false
    t.decimal "energy_price_for_kwh"
    t.decimal "avg_energy_consumption"
    t.text "token"
    t.string "api_turn_on_url"
    t.string "api_turn_off_url"
    t.integer "off_timeout", default: 5, null: false
    t.index ["network_id"], name: "index_smart_plug_devices_on_network_id"
  end

  create_table "uptime_stats", force: :cascade do |t|
    t.integer "endpoint_device_id", null: false
    t.boolean "available", default: false, null: false
    t.datetime "check_date", precision: nil
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_id"], name: "index_uptime_stats_on_network_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
