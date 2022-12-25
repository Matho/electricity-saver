class RenameIpAddressToApiUrl < ActiveRecord::Migration[7.0]
  def change
    rename_column :smart_plug_devices, :ip_address, :api_url
  end
end
