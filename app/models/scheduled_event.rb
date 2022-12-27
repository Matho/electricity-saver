class ScheduledEvent < ApplicationRecord
  TIMEOUT_FOR_OFF_STATE = 1.hour

  belongs_to :network
  belongs_to :smart_plug_device

  validates :event_date, presence: true
  validates :smart_plug_device_id, presence: true
  validates :action, presence: true
  validates :network_id, presence: true

  enum :action, { turned_on: '0', turned_off: '1' }
  enum :status, { scheduled: '0', finished: '1', failed: '2'}

  scope :last_sorted, -> { limit(5).order(id: :desc) }
end
