json.extract! ping_stat, :id, :ip_addresss, :response_time, :response_code, :response_status, :created_at, :updated_at
json.url ping_stat_url(ping_stat, format: :json)
