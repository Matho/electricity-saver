class ScheduledEventsService

  def initialize(network)
    @network = network
  end

  def process
    datetimes_for_rules = []

    @network.rules.each do |rule|
      crons = [
        rule.cron_monday,
        rule.cron_tuesday,
        rule.cron_wednesday,
        rule.cron_thursday,
        rule.cron_friday,
        rule.cron_saturday,
        rule.cron_sunday
      ].compact_blank

      cron_times = crons.map do |cron|
        cron_parser = CronParser.new(cron)
        cron_parser.next(Time.now)
      end

      closest_datetime = cron_times.sort! {|a,b| a <=> b }.try(:first)

      datetimes_for_rules << [
        rule, closest_datetime
      ]
    end

    datetimes_for_rules
  end
end