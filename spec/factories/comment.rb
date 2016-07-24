FactoryGirl.define do
  factory :comment do
    sequence(:thoughts) { |n| "This is my comment #{n}"}
    user
    post
  end
end
