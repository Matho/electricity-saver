class EventLog < ApplicationRecord
  belongs_to :network

  validates :title, presence: true
  validates :event_date, presence: true
  validates :endpoint_device_id, presence: true
  validates :network_id, presence: true
end
