FactoryBot.define do
  sequence :name do |n|
    "MyTypejob#{n}"
  end
  factory :typejob do
    name
  end
end
