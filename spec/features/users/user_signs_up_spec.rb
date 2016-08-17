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

  context 'having a username with' do
    scenario 'less than 3 characters' do
      user = build(:user, username: 'w')

      sign_up_as user

      expect(page).to have_content t('errors.messages.too_short.other', count: 3)
    end
  end

  scenario 'having a username with more than 12 characters' do
    user = build(:user, username: 'johndoeknucklesjames')

    sign_up_as user

    expect(page).to have_content t('errors.messages.too_long.other', count: 12)
  end
end
