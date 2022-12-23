class CreateSavedEnergies < ActiveRecord::Migration[7.0]
  def change
    create_table :saved_energies do |t|
      t.integer :smart_plug_device_id
      t.integer :savings
      t.integer :network_id

      t.timestamps
    end
  end
end
