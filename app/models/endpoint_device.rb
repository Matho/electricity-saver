require "resolv"
class EndpointDevice < ApplicationRecord
  belongs_to :network
  has_many :event_logs, as: :event_loggable, dependent: :restrict_with_error
  has_many :uptime_stats, dependent: :restrict_with_error

  validates :title, presence: true
  validates :network_id, presence: true
  validates :active_monitoring, inclusion: { in: [ true, false ] }
  validates :ip_address, :presence => true

  scope :with_active_monitoring, -> { where(active_monitoring: true) }
end
