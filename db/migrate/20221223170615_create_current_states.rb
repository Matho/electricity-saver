class CreateCurrentStates < ActiveRecord::Migration[7.0]
  def change
    create_table :current_states do |t|
      t.string :state, null: false
      t.integer :smart_plug_device_id, null: false
      t.integer :network_id, null: false

      t.references :network_id
      t.timestamps
    end
  end
end
