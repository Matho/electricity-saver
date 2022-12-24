class CreateSmartPlugDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :smart_plug_devices do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.string :api_title, null: false
      t.string :current_state, null: false
      t.string :ip_address, null: false

      t.references :network, null: false
      t.timestamps
    end
  end
end
