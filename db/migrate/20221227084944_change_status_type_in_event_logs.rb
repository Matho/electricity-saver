class ChangeStatusTypeInEventLogs < ActiveRecord::Migration[7.0]
  def change
    change_column :event_logs, :status, :string
  end
end
