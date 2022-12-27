FactoryBot.define do
  factory :smart_plug_device do
    association :network, strategy: :create

    title { 'Zasuvka 1090' }
    api_title { 'zasuvka.1090' }
    current_state { '0' }
    api_status_url { 'url' }
    energy_price_for_kwh { 0.23 }
    avg_energy_consumption { 50 }
    token { 'token' }
    api_turn_on_url { 'url' }
    api_turn_off_url { 'url' }
    off_timeout { 60 }
  end
end

