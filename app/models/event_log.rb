class EventLog < ApplicationRecord
  belongs_to :network
  belongs_to :endpoint_device

  validates :status, presence: true
  validates :event_date, presence: true
  validates :endpoint_device_id, presence: true
  validates :network_id, presence: true

  enum :status, { turned_on: 0, turned_off: 1, unavailable: 2 }

  scope :last_sorted, -> { limit(5).order('id desc') }
end
