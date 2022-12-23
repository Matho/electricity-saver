class CreateCurrentStates < ActiveRecord::Migration[7.0]
  def change
    create_table :current_states do |t|
      t.string :state
      t.integer :smart_plug_device_id
      t.integer :network_id

      t.timestamps
    end
  end
end
