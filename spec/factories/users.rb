FactoryBot.define do
  factory :user do
    age { Faker::Number.between(from: 18, to: 65) }
    dependents { Faker::Number.between(from: 0, to: 5) }
    house { { ownership_status: Faker::Boolean.boolean ? 'owned' : 'rented' } }
    income { Faker::Number.between(from: 0, to: 10000) }
    marital_status { Faker::Boolean.boolean ? 'single' : 'married' }
    risk_questions { Array.new(3) { Faker::Number.between(from: 0, to: 1) } }
    vehicle { { year: Faker::Number.between(from: 2000, to: Time.now.year) } }
  end
end
