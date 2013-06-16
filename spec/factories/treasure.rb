FactoryGirl.define do
  factory :treasure do
    name {Faker::Name.first_name}
    description {Faker::Lorem.sentence}
    photo {Faker::Internet.url}
    price {Faker::Address.zip_code}
  end
end

