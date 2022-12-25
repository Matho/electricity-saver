class UptimeStat < ApplicationRecord
  belongs_to :network
  belongs_to :endpoint_device

  validates :endpoint_device_id, presence: true
  validates :available, inclusion: [true, false]
  validates :network_id, presence: true

  scope :last_sorted, -> { limit(5).order('id desc') }
end
