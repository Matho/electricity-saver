class CreatePingStats < ActiveRecord::Migration[7.0]
  def change
    create_table :ping_stats do |t|
      t.string :ip_addresss, null: false
      t.integer :response_time, null: true
      t.string :response_code, null: true
      t.string :response_status, null: false

      t.references :network, null: false
      t.timestamps
    end
  end
end
