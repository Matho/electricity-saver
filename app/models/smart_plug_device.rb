class SmartPlugDevice < ApplicationRecord
  belongs_to :network
  has_many :current_states

  validates :title, presence: true
  validates :api_title, presence: true
  validates :current_state, presence: true
  validates :ip_address, presence: true
  validates :network_id, presence: true

  enum :current_state, { turned_on: '0', turned_off: '1', unknown: '2' }
end
