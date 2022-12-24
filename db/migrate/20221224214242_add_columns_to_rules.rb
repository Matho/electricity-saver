class AddColumnsToRules < ActiveRecord::Migration[7.0]
  def change
    add_column :rules, :cron_saturday,:string
    add_column :rules, :cron_sunday,:string
  end
end
