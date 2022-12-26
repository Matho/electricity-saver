class AddApiUrlsToSmartPlugDevices < ActiveRecord::Migration[7.0]
  def change
    rename_column :smart_plug_devices, :api_url, :api_status_url
    add_column :smart_plug_devices, :api_turn_on_url, :string
    add_column :smart_plug_devices, :api_turn_off_url, :string
  end
end
