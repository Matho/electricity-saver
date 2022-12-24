class CreateScheduledEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :scheduled_events do |t|
      t.timestamp :event_date, null: false
      t.integer :smart_plug_device_id, null: false
      t.string :action, null: false

      t.references :network, null: false
      t.timestamps
    end
  end
end
