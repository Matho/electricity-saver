class PingStatsService
  RETRY_COUNTS = 2
  TIMEOUT_BETWEEN_REQUESTS = 0.2
  TIMEOUT = 2
  def initialize(network)
    @network = network
  end

  def process
    @network.endpoint_devices.where(active_monitoring: true).each do |endpoint_device|
      ip_address = endpoint_device.ip_address

      net_ping = Net::Ping::External.new(ip_address)

      success = net_ping.ping?(ip_address, RETRY_COUNTS, TIMEOUT_BETWEEN_REQUESTS, TIMEOUT)
      duration = net_ping.duration # miliseconds

      PingStat.create!({
                        ip_address: ip_address,
                        response_time: duration,
                        response_code: nil,
                        response_status: success ? 'OK' : 'FAIL',
                        network_id: @network.id
                      })
    end
  end
end