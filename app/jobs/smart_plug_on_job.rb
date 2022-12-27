class SmartPlugOnJob < ApplicationJob
  queue_as :critical
  sidekiq_options retry: 0

  def perform(smart_plug_device_id)
    smart_plug_device = SmartPlugDevice.find_by(id: smart_plug_device_id)

    SmartPlugOnService.new(smart_plug_device).process
  end
end
