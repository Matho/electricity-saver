class AddOffTimeoutToSmartPlugDevices < ActiveRecord::Migration[7.0]
  def change
    add_column :smart_plug_devices, :off_timeout, :integer, null: false, default: 5
  end
end
