class SavedEnergyRecomputeService
  def initialize(network)
    @network = network
  end

  def process
    @network.smart_plug_devices.each do |smart_plug_device|
      compute(smart_plug_device)
    end
  end

  private

  def compute(smart_plug_device)
    beginning_of_day = Date.yesterday.beginning_of_day
    end_of_day = Date.yesterday.end_of_day

    first_state_for_yesterday = smart_plug_device.current_states
                                                 .where('created_at < ?', beginning_of_day ).order(id: :desc)
                                                 .limit(1).first&.state.presence || 'turned_off'

    states_for_yesterday = smart_plug_device.current_states.where('created_at > ? AND created_at < ?', beginning_of_day , end_of_day ).order(id: :asc)

    last_state_for_yesterday = states_for_yesterday.last&.state.presence ||  first_state_for_yesterday

    flatten_states = [
      [first_state_for_yesterday, beginning_of_day],
      states_for_yesterday.map {|state| [state.state, state.created_at] },
      [last_state_for_yesterday, end_of_day]
    ].flatten

    hash_with_intervals = {
      'turned_off' => [],
      'turned_on' => [],
      'unknown' => []
    }

    i = 1 * 2 # skip first, do backward processing
    while i < flatten_states.length
      previous_state = flatten_states[i - 2]
      hash_with_intervals[previous_state] << [flatten_states[i - 1], flatten_states[i + 1]]

      i = i + 2
    end

    powered_on_time_in_seconds = 0

    hash_with_intervals['turned_on'].each do |interval|
      on_time = interval[1] - interval[0] # seconds
      powered_on_time_in_seconds += on_time
    end

    powered_on_time_in_hours = (powered_on_time_in_seconds / 60 / 60).round(2) # hours for ON state
    powered_off_time_in_hours = 24.0 - powered_on_time_in_hours

    watt_hours_off_for_day = smart_plug_device.avg_energy_consumption * powered_off_time_in_hours
    total_energy_price = watt_hours_off_for_day * (smart_plug_device.energy_price_for_kwh / 1000) # EUR

    saved_energy = SavedEnergy.find_or_initialize_by(day: Date.yesterday)
    saved_energy.assign_attributes({
                                     smart_plug_device_id: smart_plug_device.id,
                                     savings: watt_hours_off_for_day,
                                     network_id: @network.id,
                                     total_energy_price: total_energy_price,
                                     powered_on_hours: powered_on_time_in_hours,
                                     powered_off_hours: powered_off_time_in_hours,
                                     energy_price_for_kwh: smart_plug_device.energy_price_for_kwh
                                   })
    saved_energy.save!
  end
end
