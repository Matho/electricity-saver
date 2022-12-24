class ChangeColumnTypeInEventLog < ActiveRecord::Migration[7.0]
  def change
    remove_column :event_logs, :status
    add_column :event_logs, :status, :integer, null: false
  end
end
