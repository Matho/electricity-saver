json.extract! current_state, :id, :state, :smart_plug_device_id, :network_id, :created_at, :updated_at
json.url current_state_url(current_state, format: :json)
