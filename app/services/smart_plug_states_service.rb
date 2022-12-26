class SmartPlugStatesService
  SUCCESS_API_CODE = 200

  def initialize(network)
    @network = network
  end

  def process
    @network.smart_plug_devices.each do |smart_plug_device|
      state = detect(smart_plug_device)

      smart_plug_device.update!(current_state: state)

      # we want to save only changes, not every request change
      next if CurrentState.last.state == state.to_s

      CurrentState.create!({
                             state: state,
                             smart_plug_device_id: smart_plug_device.id,
                             network_id: @network.id
                           })
    end
  end

  private

  def detect(smart_plug_device)
    begin
      response = HTTParty.get(smart_plug_device.api_status_url,
                              headers: {
                                "content-type" => 'application/json',
                                "Authorization" => "Bearer #{smart_plug_device.token}"
                              },
                              open_timeout: 2.0)
    rescue => e
      return :unknown
    end

    # request has failed, we dont know if plug is on or off
    return :unknown unless request_passed?(response)

    begin
      parsed_body = JSON.parse(response.body)
    rescue => e
      return :unknown
    end

    api_state = parsed_body['state']&.to_sym

    case api_state
    when 'on'
      :turned_on
    when 'off'
      :turned_off
    else
      :unknown
    end
  end

  def request_passed?(response)
    response.code == SUCCESS_API_CODE
  end
end
