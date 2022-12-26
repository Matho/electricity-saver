class UptimeStat < ApplicationRecord
  belongs_to :network
  belongs_to :endpoint_device

  validates :endpoint_device_id, presence: true
  validates :available, inclusion: [true, false]
  validates :network_id, presence: true

  scope :last_sorted, -> { limit(5).order('id desc') }

  after_commit :create_event_log, on: [:create, :update]

  private

  def create_event_log
    return nil unless available_previously_changed?

    EventLog.create!({
                       event_date: Time.current,
                       endpoint_device_id: self.endpoint_device_id,
                       network_id: self.network_id,
                       status: self.available ? :turned_on : :turned_off
                     })
  end
end
