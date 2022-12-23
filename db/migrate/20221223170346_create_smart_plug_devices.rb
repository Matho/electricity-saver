class CreateSmartPlugDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :smart_plug_devices do |t|
      t.string :title
      t.text :description
      t.string :api_title
      t.string :current_state
      t.string :ip_address
      t.integer :network_id

      t.timestamps
    end
  end
end
