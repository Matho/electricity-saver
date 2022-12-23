class CreateEventLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :event_logs do |t|
      t.string :title
      t.timestamp :event_date
      t.integer :endpoint_device_id

      t.timestamps
    end
  end
end
