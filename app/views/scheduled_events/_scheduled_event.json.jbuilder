json.extract! scheduled_event, :id, :event_date, :smart_plug_device_id, :action, :created_at, :updated_at
json.url scheduled_event_url(scheduled_event, format: :json)
