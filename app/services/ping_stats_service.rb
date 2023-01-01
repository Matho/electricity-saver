class PingStatsService
  RETRY_COUNTS = 2
  TIMEOUT = 2
  DEFAULT_PING_PORT = 80

  def initialize(network)
    @network = network
  end

  def process
    @network.endpoint_devices.with_active_monitoring.each do |endpoint_device|
      host, port = endpoint_device.ip_address.split(':')

      net_ping = Net::Ping::TCP.new(host, port.presence || DEFAULT_PING_PORT, TIMEOUT)

      success = net_ping.ping?
      duration = net_ping.duration.to_d * 1000.0 # ms

      PingStat.create!({
                        ip_address: endpoint_device.ip_address,
                        response_time: duration.round(2),
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