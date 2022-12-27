class ScheduledEventsService

  def initialize(network)
    @network = network
  end

  def process
    datetimes_for_rules = []
    current_day_name = Time.current.strftime("%A").downcase

    @network.rules.each do |rule|
      crons = [
        rule.send("cron_#{current_day_name}".to_sym),
      ].compact_blank

      cron_times = crons.map do |cron|
        cron_parser = CronParser.new(cron)
        cron_parser.next(Time.current)
      end

      closest_datetime = cron_times.sort! {|a,b| a <=> b }.try(:first)

      if closest_datetime.present?
        datetimes_for_rules << [
          rule, closest_datetime
        ]
      end
    end

    datetimes_for_rules
  end
end