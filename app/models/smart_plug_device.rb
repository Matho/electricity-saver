class SmartPlugDevice < ApplicationRecord
  belongs_to :network

  validates :title, presence: true
  validates :api_title, presence: true
  validates :current_state, presence: true
  validates :ip_address, presence: true
  validates :network_id, presence: true
end
