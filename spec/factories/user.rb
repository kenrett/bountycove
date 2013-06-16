FactoryGirl.define do
  factory :captain do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    username {first_name.downcase}
    email {Faker::Internet.email}
    password 'password'
    password_confirmation 'password'
  end
end
