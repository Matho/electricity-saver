FactoryBot.define do
  factory :endpoint_device do
    association :network, strategy: :create

    title { 'Chaty AP1' }
    ip_address { '10.0.3.10' }
    active_monitoring { true }
  end
end
