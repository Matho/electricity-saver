FactoryBot.define do
  factory :ping_stat do
    association :network, strategy: :create

    ip_address { '10.0.3.10' }
    response_status { 'OK' }
  end
end
