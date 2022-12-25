class RenameIpAddresssInPingStats < ActiveRecord::Migration[7.0]
  def change
    rename_column :ping_stats, :ip_addresss, :ip_address
  end
end
