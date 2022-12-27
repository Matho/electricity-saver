FactoryBot.define do
  factory :event_log do
    association :network, strategy: :create
    association :event_loggable, strategy: :create, factory: :endpoint_device

    event_date { Date.today }
    status { :turned_on }
  end
end
