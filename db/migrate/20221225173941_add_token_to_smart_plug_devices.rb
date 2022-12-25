class AddTokenToSmartPlugDevices < ActiveRecord::Migration[7.0]
  def change
    add_column :smart_plug_devices, :token, :text
  end
end
