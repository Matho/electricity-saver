class AddNullToTables < ActiveRecord::Migration[7.0]
  def change
    change_column_null :endpoint_devices, :ip_address, :false
    change_column_null :saved_energies, :savings, :false
    change_column_null :saved_energies, :total_energy_price, :false
    change_column_null :saved_energies, :powered_on_hours, :false
    change_column_null :saved_energies, :powered_off_hours, :false
    change_column_null :smart_plug_devices, :energy_price_for_kwh, :false
    change_column_null :smart_plug_devices, :avg_energy_consumption, :false
    change_column_null :smart_plug_devices, :token, :false
    change_column_null :smart_plug_devices, :api_turn_on_url, :false
    change_column_null :smart_plug_devices, :api_turn_off_url, :false
    change_column_null :uptime_stats, :check_date, :false
  end
end
