require 'rails_helper'

# As a User
# So that I can post pictures on Pixagram as me
# I want to register for my account
feature 'User signs up' do
  scenario 'with valid credentials' do
    user = build :user

    sign_up_as user

    expect(page).to have_content t('devise.registrations.signed_up')
  end

  scenario 'without a username' do
    user = build(:user, username: nil)

    sign_up_as user

    expect(page).to have_content t('errors.messages.blank')
  end

  scenario 'having a username with less than 3 characters' do
    user = build(:user, username: 'w')

    sign_up_as user

    expect(page).to have_content t('errors.messages.too_short.other', count: 3)
  end

  scenario 'having a username with more than 16 characters' do
    user = build(:user, username: 'johndoeknucklesjames')

    sign_up_as user

    expect(page).to have_content t('errors.messages.too_long.other', count: 16)
  end
end
