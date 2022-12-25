class SmartPlugStateJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 0

  def perform(*args)
    Network.where(active: true).each do |network|
      SmartPlugStatesService.new(network).process
    end
  end
end
