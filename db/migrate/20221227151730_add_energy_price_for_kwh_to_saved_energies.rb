class AddEnergyPriceForKwhToSavedEnergies < ActiveRecord::Migration[7.0]
  def change
    add_column :saved_energies, :energy_price_for_kwh, :decimal, default: 0
  end
end
