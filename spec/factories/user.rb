FactoryGirl.define do
  factory :user do
    sequence(:username)   { |n| "johndoe_#{n}" }
    sequence(:email)      { |n| "johndoe_#{n}@email.com" }
    password              'password'
    password_confirmation 'password'
  end
end

