class ScheduleCronEventsJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 0

  def perform(*args)
    Network.with_active.each do |network|
      ScheduleCronEventsService.new(network).process
    end
  end
end
