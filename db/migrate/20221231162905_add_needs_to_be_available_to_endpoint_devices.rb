class AddNeedsToBeAvailableToEndpointDevices < ActiveRecord::Migration[7.0]
  def change
    add_column :endpoint_devices, :needs_to_be_available, :boolean, null: false, default: false
  end
end
