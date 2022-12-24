class SavedEnergy < ApplicationRecord
  belongs_to :network
  belongs_to :smart_plug_device

  validates :smart_plug_device_id, presence: true
  validates :network_id, presence: true

  scope :last_sorted, -> { limit(5).order('id desc') }
end
