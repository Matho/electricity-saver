class SmartPlugOffJob < ApplicationJob
  queue_as :critical
  sidekiq_options retry: 0

  def perform(params)
    smart_plug_device = SmartPlugDevice.find_by(id: params[:smart_plug_device_id])

    SmartPlugOffService.new(smart_plug_device).process
  end
end
