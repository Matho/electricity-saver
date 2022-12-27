class Network < ApplicationRecord
  has_many :current_states, dependent: :destroy
  has_many :endpoint_devices, dependent: :destroy
  has_many :event_logs, dependent: :destroy
  has_many :ping_stats, dependent: :destroy
  has_many :rules, dependent: :destroy
  has_many :saved_energies, dependent: :destroy
  has_many :scheduled_events, dependent: :destroy
  has_many :smart_plug_devices, dependent: :destroy
  has_many :uptime_stats, dependent: :destroy

  validates :title, presence: true
  validates :active, inclusion: { in: [ true, false ] }
end
