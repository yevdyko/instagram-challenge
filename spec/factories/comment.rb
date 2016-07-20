FactoryGirl.define do
  factory :comment do
    id 1
    thoughts 'This is my comment'
    user_id 1
    post_id 1
  end
end
