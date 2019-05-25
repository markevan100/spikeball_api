FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email { Faker::Internet.email }
    password_digest { Faker::Lorem.word }
  end
end
