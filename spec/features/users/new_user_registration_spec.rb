require 'rails_helper'

# As a User
# So that I can post pictures on Instagram as me
# I want to register for my account
feature 'New user registration' do
  scenario 'can create a new user account' do
    user = build :user
    sign_up_as user
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'requires a username to successfully create an account' do
    user = build(:user, username: nil)
    sign_up_as user
    expect(page).to have_content "can't be blank"
  end

  scenario 'requires a username to be more than 3 characters' do
    user = build(:user, username: 'w')
    sign_up_as user
    expect(page).to have_content 'minimum is 3 characters'
  end

  scenario 'requires a username to be less 16 characters' do
    user = build(:user, username: 'johndoeknucklesjames')
    sign_up_as user
    expect(page).to have_content('maximum is 16 characters')
  end
end
