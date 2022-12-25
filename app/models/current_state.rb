class CurrentState < ApplicationRecord
  belongs_to :network
  belongs_to :smart_plug_device

  validates :state, presence: true
  validates :smart_plug_device_id, presence: true
  validates :network_id, presence: true

  enum :state, { turned_on: '0', turned_off: '1', unknown: '2' }
end
