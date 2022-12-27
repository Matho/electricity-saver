FactoryBot.define do
  factory :rule do
    association :smart_plug_device, strategy: :create
    association :network, strategy: :create

    rule { 'Rule title' }
    action { '0' }
  end
end
