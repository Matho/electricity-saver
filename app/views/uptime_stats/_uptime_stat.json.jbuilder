json.extract! uptime_stat, :id, :endpoint_device_id, :available, :check_date, :network_id, :created_at, :updated_at
json.url uptime_stat_url(uptime_stat, format: :json)
