class AddPoweredOnAndOffHoursToSavedEnergies < ActiveRecord::Migration[7.0]
  def change
    add_column :saved_energies, :powered_on_hours, :decimal
    add_column :saved_energies, :powered_off_hours, :decimal
  end
end
