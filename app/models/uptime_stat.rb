class UptimeStat < ApplicationRecord
  belongs_to :network
  belongs_to :endpoint_device

  validates :endpoint_device_id, presence: true
  validates :available, inclusion: [true, false]
  validates :network_id, presence: true

  scope :last_sorted, -> { limit(5).order(id: :desc) }

  after_create :create_event_log
  after_update :create_event_log, if: :available_previously_changed?

  private

  def create_event_log
    EventLog.create!({
                       event_date: Time.current,
                       event_loggable: self.endpoint_device,
                       network_id: self.network_id,
                       status: self.available ? :turned_on : :turned_off
                     })
  end
end
