require "resolv"
class EndpointDevice < ApplicationRecord
  belongs_to :network

  validates :title, presence: true
  validates :network_id, presence: true
  validates :ip_address, :presence => true,
            :format => {
              :with => Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex), :message => "Not an valid IP format"
            }
end
