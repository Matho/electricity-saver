class EventLog < ApplicationRecord
  belongs_to :network
  belongs_to :event_loggable, polymorphic: true

  validates :status, presence: true
  validates :event_date, presence: true
  validates :event_loggable, presence: true
  validates :network_id, presence: true

  enum :status, { turned_on: '0', turned_off: '1', unknown: '2' }

  scope :last_sorted, -> { limit(5).order(id: :desc) }

  after_create :create_scheduled_event

  private

  def create_scheduled_event
    # we want to schedule events only for not available endpoint devices, not for smart plugs
    return nil if self.event_loggable_type == 'SmartPlugDevice'

    # we are taking first smart plug, because of it only 1 smart plug is currently supported for network
    smart_plug_device = self.network.smart_plug_devices.first

    return nil unless smart_plug_device
    return nil if self.status == 'unknown'

    event_date = Time.current

    if self.status == 'turned_off'
      event_date = event_date + ScheduledEvent::TIMEOUT_FOR_OFF_STATE
    end

    ScheduledEvent.create!({
                             event_date: event_date,
                             smart_plug_device_id: smart_plug_device.id,
                             action: self.status,
                             network_id: self.network.id
                           })
  end
end
