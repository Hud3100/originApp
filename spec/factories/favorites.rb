FactoryBot.define do
  factory :favorite, class: Favorite do
    association :user
    user_id { 1 }
    micropost_id { 1 }

    trait :invalid_favorite do
      micropost_id { nil }
    end
  end
end
