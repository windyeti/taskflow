FactoryBot.define do
  factory :status do
    sequence(:name) { |n| "MyStatus#{n}" }
  end
end
