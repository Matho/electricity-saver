class AddReasonToScheduledEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :scheduled_events, :reason, :text, null: true
  end
end
