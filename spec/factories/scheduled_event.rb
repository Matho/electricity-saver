FactoryBot.define do
  factory :scheduled_event do
    association :network, strategy: :create
    association :smart_plug_device, strategy: :create

    event_date { Date.today }
    action { '0' }
    status { :scheduled }
    reason { nil }
  end
end
