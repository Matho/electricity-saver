class ChangeResponseTimeToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :ping_stats, :response_time, :decimal
  end
end
