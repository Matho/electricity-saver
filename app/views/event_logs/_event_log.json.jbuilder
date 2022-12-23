json.extract! event_log, :id, :title, :event_date, :endpoint_device_id, :created_at, :updated_at
json.url event_log_url(event_log, format: :json)
