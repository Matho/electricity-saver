class AutomatService #TODO create job scheduled by cron every minute

  def initialize(network)
    @network = network
  end

  def process
    @network.scheduled_events.where(status: :scheduled).each do |scheduled_event|
      compute(scheduled_event)
    end
  end

  private

  def compute(scheduled_event)
    endpoint_devices = @network.endpoint_devices.where(active_monitoring: true)

    devices_states = @network.uptime_stats.where(endpoint_device_id: endpoint_devices)

    case scheduled_event.action
    when 'turned_on'
      could_be_turned_on?(scheduled_event, devices_states)
    when 'turned_off'
      could_be_turned_off?(scheduled_event, devices_states)
    end
  end

  def could_be_turned_on?(scheduled_event, devices_states)
    if devices_states.map(&:available).include?(true)
      # TODO execute api request to turn on the smart plug
      p "turning on"
      scheduled_event.update(status: :finished)
    end
  end

  def could_be_turned_off?(scheduled_event, devices_states)
    if devices_states.map(&:available).uniq == false # if all devices are off
      # TODO execute api request to turn OFF the smart plug
      p "turning off"
      scheduled_event.update(status: :finished)
    else
      reason = 'Device states: '

      devices_states.map do |device_state|
        reason << [device_state.endpoint_device.ip_address, device_state.available ? '(ON) ' : '(OFF) '].join('')
      end

      scheduled_event.update(status: :failed, reason: reason)
    end
  end
end