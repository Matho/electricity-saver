class CreateEventLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :event_logs do |t|
      t.string :title, null: false
      t.timestamp :event_date, null: false
      t.integer :endpoint_device_id, null: false
      t.integer :network_id, null: false

      t.references :network_id
      t.timestamps
    end
  end
end
