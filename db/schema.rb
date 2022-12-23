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

ActiveRecord::Schema[7.0].define(version: 2022_12_23_170928) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_states", force: :cascade do |t|
    t.string "state"
    t.integer "smart_plug_device_id"
    t.integer "network_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "endpoint_devices", force: :cascade do |t|
    t.string "title"
    t.string "gps_position"
    t.text "description"
    t.string "ip_address"
    t.string "contact_info"
    t.integer "network_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_logs", force: :cascade do |t|
    t.string "title"
    t.datetime "event_date", precision: nil
    t.integer "endpoint_device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "networks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ping_stats", force: :cascade do |t|
    t.string "ip_addresss"
    t.integer "response_time"
    t.string "response_code"
    t.string "response_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rules", force: :cascade do |t|
    t.string "rule"
    t.integer "smart_plug_device_id"
    t.string "action"
    t.string "cron_monday"
    t.string "cron_tuesday"
    t.string "cron_wednesday"
    t.string "cron_thursday"
    t.string "cron_friday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saved_energies", force: :cascade do |t|
    t.integer "smart_plug_device_id"
    t.integer "savings"
    t.integer "network_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_events", force: :cascade do |t|
    t.datetime "event_date", precision: nil
    t.integer "smart_plug_device_id"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smart_plug_devices", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "api_title"
    t.string "current_state"
    t.string "ip_address"
    t.integer "network_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uptime_stats", force: :cascade do |t|
    t.integer "endpoint_device_id"
    t.boolean "available"
    t.datetime "check_date", precision: nil
    t.integer "network_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
