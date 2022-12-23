class CreateEndpointDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoint_devices do |t|
      t.string :title
      t.string :gps_position
      t.text :description
      t.string :ip_address
      t.string :contact_info
      t.integer :network_id

      t.timestamps
    end
  end
end
