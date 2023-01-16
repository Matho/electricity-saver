class SmartPlugStateJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(*args)
    Network.with_active.each do |network|
      SmartPlugStatesService.new(network).process
    end
  end
end
