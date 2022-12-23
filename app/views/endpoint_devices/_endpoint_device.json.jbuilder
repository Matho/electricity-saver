json.extract! endpoint_device, :id, :title, :gps_position, :description, :ip_address, :contact_info, :network_id, :created_at, :updated_at
json.url endpoint_device_url(endpoint_device, format: :json)
