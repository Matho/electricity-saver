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

ActiveRecord::Schema[7.0].define(version: 2022_12_31_162905) do
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
    t.index ["smart_plug_device_id"], name: "index_current_states_on_smart_plug_device_id"
    t.index ["state"], name: "index_current_states_on_state"
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
    t.boolean "needs_to_be_available", default: false, null: false
    t.index ["active_monitoring"], name: "index_endpoint_devices_on_active_monitoring"
    t.index ["ip_address"], name: "index_endpoint_devices_on_ip_address"
    t.index ["network_id"], name: "index_endpoint_devices_on_network_id"
  end

  create_table "event_logs", force: :cascade do |t|
    t.datetime "event_date", precision: nil, null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", null: false
    t.integer "event_loggable_id", null: false
    t.string "event_loggable_type", null: false
    t.index ["event_date"], name: "index_event_logs_on_event_date"
    t.index ["event_loggable_id"], name: "index_event_logs_on_event_loggable_id"
    t.index ["event_loggable_type", "event_loggable_id"], name: "index_event_logs_on_event_loggable_type_and_event_loggable_id"
    t.index ["event_loggable_type"], name: "index_event_logs_on_event_loggable_type"
    t.index ["network_id"], name: "index_event_logs_on_network_id"
    t.index ["status"], name: "index_event_logs_on_status"
  end

  create_table "networks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_networks_on_active"
  end

  create_table "ping_stats", force: :cascade do |t|
    t.string "ip_address", null: false
    t.decimal "response_time"
    t.string "response_code"
    t.string "response_status", null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip_address"], name: "index_ping_stats_on_ip_address"
    t.index ["network_id"], name: "index_ping_stats_on_network_id"
    t.index ["response_status"], name: "index_ping_stats_on_response_status"
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
    t.index ["action"], name: "index_rules_on_action"
    t.index ["network_id"], name: "index_rules_on_network_id"
    t.index ["smart_plug_device_id"], name: "index_rules_on_smart_plug_device_id"
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
    t.decimal "energy_price_for_kwh", default: "0.0"
    t.index ["network_id"], name: "index_saved_energies_on_network_id"
    t.index ["smart_plug_device_id"], name: "index_saved_energies_on_smart_plug_device_id"
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
    t.index ["action"], name: "index_scheduled_events_on_action"
    t.index ["event_date"], name: "index_scheduled_events_on_event_date"
    t.index ["network_id"], name: "index_scheduled_events_on_network_id"
    t.index ["smart_plug_device_id"], name: "index_scheduled_events_on_smart_plug_device_id"
    t.index ["status"], name: "index_scheduled_events_on_status"
  end

  create_table "smart_plug_devices", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "api_title", null: false
    t.string "current_state", null: false
    t.string "api_status_url", null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["available"], name: "index_uptime_stats_on_available"
    t.index ["endpoint_device_id"], name: "index_uptime_stats_on_endpoint_device_id"
    t.index ["network_id"], name: "index_uptime_stats_on_network_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
