class CreateEndpointDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoint_devices do |t|
      t.string :title, null: false
      t.string :gps_position, null: true
      t.text :description, null: true
      t.string :ip_address, null: true
      t.string :contact_info, null: true

      t.references :network, null: false
      t.timestamps
    end
  end
end
