FactoryGirl.define do
  factory :user do
    username              'johndoe'
    email                 'johndoe@email.com'
    password              'password'
    password_confirmation 'password'
  end
end
