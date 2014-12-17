FactoryGirl.define do
  factory :host do
    name { Faker::Internet.domain_word }
    type { HostType::AVAILABLE_TYPES.sample }

    trait :server do
      host_type { HostType.new 'server' }
    end

    trait :apc do
      host_type { HostType.new 'apc' }
    end

  end

end
