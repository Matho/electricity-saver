class CreatePingStats < ActiveRecord::Migration[7.0]
  def change
    create_table :ping_stats do |t|
      t.string :ip_addresss, null: false
      t.integer :response_time, null: true
      t.string :response_code, null: true
      t.string :response_status, null: false
      t.integer :network_id, null: false

      t.references :network_id
      t.timestamps
    end
  end
end
