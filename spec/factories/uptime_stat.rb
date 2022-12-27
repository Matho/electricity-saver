FactoryBot.define do
  factory :uptime_stat do
    association :network, strategy: :create
    association :endpoint_device, strategy: :create

    available { true }
    check_date { Date.today }
  end
end
