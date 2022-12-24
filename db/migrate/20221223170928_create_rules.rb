class CreateRules < ActiveRecord::Migration[7.0]
  def change
    create_table :rules do |t|
      t.string :rule, null: false
      t.integer :smart_plug_device_id, null: false
      t.string :action, null: false
      t.string :cron_monday, null: true
      t.string :cron_tuesday, null: true
      t.string :cron_wednesday, null: true
      t.string :cron_thursday, null: true
      t.string :cron_friday, null: true

      t.references :network, null: false
      t.timestamps
    end
  end
end
