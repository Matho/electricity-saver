class ScheduleCronEventsJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 0

  def perform(*args)
    Network.where(active: true).each do |network|
      ScheduleCronEventsService.new(network).process
    end
  end
end
