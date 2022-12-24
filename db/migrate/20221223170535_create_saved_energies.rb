class CreateSavedEnergies < ActiveRecord::Migration[7.0]
  def change
    create_table :saved_energies do |t|
      t.integer :smart_plug_device_id, null: false
      t.integer :savings, null: true

      t.references :network, null: false
      t.timestamps
    end
  end
end
