class EndpointDevice < ApplicationRecord
  belongs_to :network

  validates :title, presence: true
  validates :network_id, presence: true
  validates :ip_address, presence: true
end
