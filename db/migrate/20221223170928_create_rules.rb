class CreateRules < ActiveRecord::Migration[7.0]
  def change
    create_table :rules do |t|
      t.string :rule
      t.integer :smart_plug_device_id
      t.string :action
      t.string :cron_monday
      t.string :cron_tuesday
      t.string :cron_wednesday
      t.string :cron_thursday
      t.string :cron_friday

      t.timestamps
    end
  end
end
