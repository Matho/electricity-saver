class Rule < ApplicationRecord
  belongs_to :network

  validates :rule, presence: true
  validates :smart_plug_device_id, presence: true
  validates :action, presence: true
  validates :network_id, presence: true
end
