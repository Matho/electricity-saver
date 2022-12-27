class SmartPlugDevice < ApplicationRecord
  belongs_to :network
  has_many :current_states, dependent: :restrict_with_error
  has_many :rules, dependent: :restrict_with_error
  has_many :event_logs, as: :event_loggable, dependent: :restrict_with_error

  validates :title, presence: true
  validates :api_title, presence: true
  validates :current_state, presence: true
  validates :api_status_url, presence: true
  validates :api_turn_on_url, presence: true
  validates :api_turn_off_url, presence: true
  validates :network_id, presence: true
  validates :energy_price_for_kwh, presence: true
  validates :avg_energy_consumption, presence: true
  validates :token, presence: true

  enum :current_state, { turned_on: '0', turned_off: '1', unknown: '2' }
end
