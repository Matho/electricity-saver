class AddDateToSavedEnergy < ActiveRecord::Migration[7.0]
  def change
    add_column :saved_energies, :day, :date, null: false
  end
end
