class AddEnergyPriceToSmartPlugDevices < ActiveRecord::Migration[7.0]
  def change
    add_column :smart_plug_devices, :energy_price_for_kwh, :decimal
  end
end
