FactoryBot.define do
  factory :micropost, class: Micropost do
    association :user
    title { "sample" }
    content { "Sampletext" }
    budget { 30 }
    car_name { "S2000" }
  end
end
