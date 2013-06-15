FactoryGirl.define do
  factory :task do
    worth { rand(1000) }
    name {Faker::Name.name}
    description {Faker::Lorem.sentences.to_s}
    captain_id { rand(100) }
  end
end
