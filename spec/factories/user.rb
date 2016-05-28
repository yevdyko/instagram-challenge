FactoryGirl.define do
  factory :user do
    email                 'johndoe@email.com'
    password              'password'
    password_confirmation 'password'
  end
end
