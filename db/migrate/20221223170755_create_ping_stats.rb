class CreatePingStats < ActiveRecord::Migration[7.0]
  def change
    create_table :ping_stats do |t|
      t.string :ip_addresss
      t.integer :response_time
      t.string :response_code
      t.string :response_status

      t.timestamps
    end
  end
end
