FactoryBot.define do
  factory :event do
    creator { Faker::Number.number(2).to_i }
    timing { Faker::Time.between(2.days.ago, Time.now) }
    where { Faker::Lorem.word }
  end
end 
