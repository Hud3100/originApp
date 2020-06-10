FactoryBot.define do
  factory :company, class: Company do
    sequence(:name) { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { "password" }
    sequence(:password_confirmation) { "password" }
  end
end
