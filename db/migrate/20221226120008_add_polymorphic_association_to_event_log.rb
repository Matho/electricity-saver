class AddPolymorphicAssociationToEventLog < ActiveRecord::Migration[7.0]
  def change
    remove_column :event_logs, :endpoint_device_id
    add_column :event_logs, :event_loggable_id, :integer, null: false
    add_column :event_logs, :event_loggable_type, :string, null: false

    add_index :event_logs, [:event_loggable_type, :event_loggable_id]
  end
end
