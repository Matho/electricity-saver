class CreateScheduledEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :scheduled_events do |t|
      t.timestamp :event_date
      t.integer :smart_plug_device_id
      t.string :action

      t.timestamps
    end
  end
end
