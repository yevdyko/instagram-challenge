require 'rails_helper'

# As a User
# So that I can post pictures on Pixagram as me
# I want to register for my account
feature 'User signs up' do
  scenario 'with valid credentials' do
    user = build :user
    sign_up_as user
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'without a username' do
    user = build(:user, username: nil)
    sign_up_as user
    expect(page).to have_content "can't be blank"
  end

  scenario 'having a username with less than 3 characters' do
    user = build(:user, username: 'w')
    sign_up_as user
    expect(page).to have_content 'minimum is 3 characters'
  end

  scenario 'having a username with more than 16 characters' do
    user = build(:user, username: 'johndoeknucklesjames')
    sign_up_as user
    expect(page).to have_content 'maximum is 16 characters'
  end
end
