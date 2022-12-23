class CreateUptimeStats < ActiveRecord::Migration[7.0]
  def change
    create_table :uptime_stats do |t|
      t.integer :endpoint_device_id
      t.boolean :available
      t.timestamp :check_date
      t.integer :network_id

      t.timestamps
    end
  end
end
