class AddActiveMonitoringToEndpointDevices < ActiveRecord::Migration[7.0]
  def change
    add_column :endpoint_devices, :active_monitoring, :boolean, default: true
  end
end
