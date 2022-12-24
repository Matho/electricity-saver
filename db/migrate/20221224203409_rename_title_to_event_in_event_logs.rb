class RenameTitleToEventInEventLogs < ActiveRecord::Migration[7.0]
  def change
    rename_column :event_logs, :title, :event
  end
end
