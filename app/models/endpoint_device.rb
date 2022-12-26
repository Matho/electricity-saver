require "resolv"
class EndpointDevice < ApplicationRecord
  belongs_to :network
  has_many :event_logs, as: :event_loggable
  has_many :uptime_stats

  validates :title, presence: true
  validates :network_id, presence: true
  validates :active_monitoring, inclusion: { in: [ true, false ] }
  validates :ip_address, :presence => true,
            :format => {
              :with => Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex), :message => "Not an valid IP format"
            }
end
