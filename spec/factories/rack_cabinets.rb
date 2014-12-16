FactoryGirl.define do
  factory :rack_cabinet do
    name { Faker::Internet.domain_word }
    location 'dc1'
  end
end
