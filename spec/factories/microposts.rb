FactoryBot.define do
  factory :micropost, class: "Micropost" do
    association :user
    title { "sample" }
    content { "Sampletext" }
    budget { 30 }
    car_name { "S2000" }

    trait :title_invalid do
      title { nil }
    end
  end
end
