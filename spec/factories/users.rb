FactoryBot.define do
  factory :user do
    age { 1 }
    dependents { 1 }
    income { 1 }
    marital_status { "MyString" }
    risk_questions { 1 }
  end
end
