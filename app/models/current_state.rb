class CurrentState < ApplicationRecord
  belongs_to :network

  validates :state, presence: true
  validates :smart_plug_device_id, presence: true
  validates :network_id, presence: true
end
