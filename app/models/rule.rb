class Rule < ApplicationRecord
  belongs_to :network
  belongs_to :smart_plug_device

  validates :rule, presence: true
  validates :smart_plug_device_id, presence: true
  validates :action, presence: true
  validates :network_id, presence: true


end
