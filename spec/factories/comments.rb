FactoryBot.define do
  factory :comment, class: Comment do
    association :user
    title { "Sample Comment" }
    content { "そのカスタムいいなあ" }
    commentable_type { "User" }

    trait :title_invalid do
      title { nil }
      content { nil }
    end
  end
end
