class RenameEventToStatusInEventLogs < ActiveRecord::Migration[7.0]
  def change
    rename_column :event_logs, :event, :status
  end
end
