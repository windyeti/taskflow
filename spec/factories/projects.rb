FactoryBot.define do
  factory :project do
    title { "MyTitle" }
    description { "MyDescription" }
    status { "MyStatus" }
    user
    trait :invalid_project do
      title { nil }
    end
  end
end
