class AddIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :current_states, :smart_plug_device_id
    add_index :current_states, :state

    add_index :endpoint_devices, :ip_address
    add_index :endpoint_devices, :active_monitoring

    add_index :event_logs, :event_date
    add_index :event_logs, :status
    add_index :event_logs, :event_loggable_id
    add_index :event_logs, :event_loggable_type

    add_index :networks, :active

    add_index :ping_stats, :ip_address
    add_index :ping_stats, :response_status

    add_index :rules, :smart_plug_device_id
    add_index :rules, :action

    add_index :saved_energies, :smart_plug_device_id

    add_index :scheduled_events, :event_date
    add_index :scheduled_events, :smart_plug_device_id
    add_index :scheduled_events, :action
    add_index :scheduled_events, :status


    add_index :uptime_stats, :endpoint_device_id
    add_index :uptime_stats, :available
  end
end
