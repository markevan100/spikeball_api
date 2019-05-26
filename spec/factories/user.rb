FactoryBot.define do
  factory :user do
    name { Faker::Internet.user_name(3) }
    email { Faker::Internet.email }
    password_digest { Faker::Lorem.word }
  end
end
