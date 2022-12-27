class SavedEnergyRecomputeJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 0

  def perform(*args)
    Network.with_active.each do |network|
      SavedEnergyRecomputeService.new(network).process
    end
  end
end
