class SmartPlugOffService
  SUCCESS_API_CODE = 200
  SUCCESS_API_MESSAGE = 'OK'.freeze
  TIMEOUT = 2.0

  def initialize(smart_plug_device)
    @smart_plug_device = smart_plug_device
  end

  def process
    do_request
  end

  private
  def do_request
    begin
      response = HTTParty.post(@smart_plug_device.api_turn_off_url,
                               body: {
                                 "entity_id": @smart_plug_device.api_title
                               }.to_json,
                               headers: {
                                 "content-type" => 'application/json',
                                 "Authorization" => "Bearer #{@smart_plug_device.token}"
                               },
                               open_timeout: TIMEOUT)
    rescue => e
      return false
    end

    response.code == SUCCESS_API_CODE && response.message == SUCCESS_API_MESSAGE
  end
end