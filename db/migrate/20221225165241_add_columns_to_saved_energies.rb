class AddColumnsToSavedEnergies < ActiveRecord::Migration[7.0]
  def change
    add_column :saved_energies, :total_energy_price, :decimal
  end
end
