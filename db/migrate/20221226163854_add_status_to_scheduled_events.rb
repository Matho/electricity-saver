class AddStatusToScheduledEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :scheduled_events, :status, :string, null: false, default: '0'
  end
end
