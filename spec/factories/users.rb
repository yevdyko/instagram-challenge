FactoryGirl.define do
  factory :user do
    sequence(:username)   { |n| "johndoe_#{n}" }
    sequence(:email)      { |n| "johndoe_#{n}@email.com" }
    password              'password'
    password_confirmation 'password'
    bio                   'Software Engineer'

    trait :with_posts do
      transient do
        posts_count 5
      end

      after :create do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end

    factory :user_with_posts do
      transient do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end

