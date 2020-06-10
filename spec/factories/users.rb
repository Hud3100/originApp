FactoryBot.define do
  factory :user, class: User do
    sequence(:name) { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { "password" }
    sequence(:password_confirmation) { "password" }
  end

  factory :another_user, class: User do
    sequence(:name) { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { "password" }
    sequence(:password_confirmation) { "password" }
  end
end
