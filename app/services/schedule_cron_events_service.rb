class ScheduleCronEventsService

  def initialize(network)
    @network = network
  end

  def process
    compute
  end

  private

  def compute
    datetimes_for_rules = ScheduledEventsService.new(@network).process

    datetimes_for_rules.each do |datetime_for_rule|
      scheduled_event = @network.scheduled_events.find_or_initialize_by({
                                                                          event_date: datetime_for_rule.second,
                                                                          smart_plug_device_id: datetime_for_rule.first.smart_plug_device.id
                                                                        })

      scheduled_event.assign_attributes({
                                          action: datetime_for_rule.first.action == 'turn_on' ? :turned_on : :turned_off,
                                          network_id: @network.id,
                                          status: :scheduled
                                        })
      scheduled_event.save!
    end
  end
end
