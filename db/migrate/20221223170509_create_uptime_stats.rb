class CreateUptimeStats < ActiveRecord::Migration[7.0]
  def change
    create_table :uptime_stats do |t|
      t.integer :endpoint_device_id, null: false
      t.boolean :available, null: false, default: false
      t.timestamp :check_date, null: true
      t.integer :network_id, null: false

      t.references :network_id
      t.timestamps
    end
  end
end
