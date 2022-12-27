FactoryBot.define do
  factory :saved_energy do
    association :network, strategy: :create
    association :smart_plug_device, strategy: :create

    savings { 10 }
    day { Date.today }
    total_energy_price { nil }
    powered_on_hours { nil }
    powered_off_hours { nil }
  end
end
