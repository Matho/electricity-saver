class PingStat < ApplicationRecord
  belongs_to :network

  validates :ip_addresss, presence: true
  validates :response_status, presence: true
  validates :network_id, presence: true

  scope :last_sorted, -> { limit(5).order('id desc') }
end
