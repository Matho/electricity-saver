class PingStatsService
  RETRY_COUNTS = 2
  TIMEOUT_BETWEEN_REQUESTS = 0.2
  TIMEOUT = 2
  def initialize(network)
    @network = network
  end

  def process
    @network.endpoint_devices.with_active_monitoring.each do |endpoint_device|
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

      uptime_stat = UptimeStat.find_or_initialize_by(endpoint_device_id: endpoint_device.id)

      uptime_stat.assign_attributes({
                           available: success,
                           check_date: Time.current,
                           network_id: @network.id
                         })
      uptime_stat.save!
    end
  end
end