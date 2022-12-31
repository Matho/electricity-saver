class AutomatService

  def initialize(network)
    @network = network
    @smart_plug_device = @network.smart_plug_devices.first # only 1 smart plug is currently allowed to create
  end

  def process
    @network.scheduled_events.with_scheduled.order_by_event_date.each do |scheduled_event|
      compute(scheduled_event)
    end
  end

  private

  def compute(scheduled_event)
    # if event is in future, do not process it
    return nil if Time.current < scheduled_event.event_date

    endpoint_devices = @network.endpoint_devices.with_needs_to_be_available

    devices_states = @network.uptime_stats.where(endpoint_device_id: endpoint_devices)

    case scheduled_event.action
    when 'turned_on'
      scheduled_event.update(attributes_for_turn_on(devices_states))
    when 'turned_off'
      scheduled_event.update(attributes_for_turn_off(devices_states))
    end
  end

  def attributes_for_turn_on(devices_states)
    if devices_states.map(&:available).include?(true)
      SmartPlugOnJob.perform_later(@smart_plug_device.id)

      {
        status: :finished
      }
    end
  end

  def attributes_for_turn_off(devices_states)
    if devices_states.map(&:available).uniq == [false] # if all devices are off
      SmartPlugOffJob.perform_later(@smart_plug_device.id)

      {
        status: :finished
      }
    else
      reason = 'Device states: '

      devices_states.map do |device_state|
        reason << [device_state.endpoint_device.ip_address, device_state.available ? '(ON) ' : '(OFF) '].join('')
      end

      {
        status: :failed,
        reason: reason
      }
    end
  end
end