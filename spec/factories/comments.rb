FactoryBot.define do
  factory :comment do
    content { "MyString" }
    company { nil }
    micropost { nil }
  end
end
