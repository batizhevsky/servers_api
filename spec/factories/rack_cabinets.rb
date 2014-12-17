FactoryGirl.define do
  factory :rack_cabinet do
    name { Faker::Internet.domain_word }
    location 'dc1'

    trait :with_server do
      after(:create) do |rack, _|
        create :host, :server, rack: rack
      end
    end

    trait :with_multi_apc do
      after(:create) do |rack, _|
        create_list :host, 2, host_type: HostType.new('apc'), rack: rack
      end
    end
  end
end
