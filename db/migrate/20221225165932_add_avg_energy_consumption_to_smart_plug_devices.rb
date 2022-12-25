class AddAvgEnergyConsumptionToSmartPlugDevices < ActiveRecord::Migration[7.0]
  def change
    add_column :smart_plug_devices, :avg_energy_consumption, :decimal
  end
end
