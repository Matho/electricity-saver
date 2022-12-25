class Network < ApplicationRecord
  has_many :current_states
  has_many :endpoint_devices
  has_many :event_logs
  has_many :ping_stats
  has_many :rules
  has_many :saved_energies
  has_many :scheduled_events
  has_many :smart_plug_devices
  has_many :uptime_stats

  validates :title, presence: true
end
