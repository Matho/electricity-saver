class EndpointDevice < ApplicationRecord
  belongs_to :network

  validates :title, presence: true
  validates :network_id, presence: true
end
