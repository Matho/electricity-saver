class UptimeStat < ApplicationRecord
  belongs_to :network
  belongs_to :endpoint_device

  validates :endpoint_device_id, presence: true
  validates :available, presence: true
  validates :network_id, presence: true
end
