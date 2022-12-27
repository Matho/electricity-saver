FactoryBot.define do
  factory :current_state do
    association :network, strategy: :create
    association :smart_plug_device, strategy: :create

    state { 'turned_on' }
  end
end
