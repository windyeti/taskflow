FactoryBot.define do
  factory :project do
    title { "MyTitle" }
    description { "MyDescription" }
    user
    status
    trait :invalid_project do
      title { nil }
    end
  end
end
