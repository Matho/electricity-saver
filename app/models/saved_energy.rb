class SavedEnergy < ApplicationRecord
  belongs_to :network

  validates :smart_plug_device_id, presence: true
  validates :network_id, presence: true
end
