class CurrentState < ApplicationRecord
  belongs_to :network
  belongs_to :smart_plug_device

  validates :state, presence: true
  validates :smart_plug_device_id, presence: true
  validates :network_id, presence: true

  enum :state, { turned_on: '0', turned_off: '1', unknown: '2' }

  after_create :create_event_log

  def create_event_log
    EventLog.create!({
                       event_date: Time.current,
                       event_loggable: self.smart_plug_device,
                       network_id: self.network_id,
                       status: self.state
                     })
  end
end
