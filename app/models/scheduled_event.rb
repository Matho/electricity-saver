class ScheduledEvent < ApplicationRecord
  belongs_to :network

  validates :event_date, presence: true
  validates :smart_plug_device_id, presence: true
  validates :action, presence: true
  validates :network_id, presence: true
end
