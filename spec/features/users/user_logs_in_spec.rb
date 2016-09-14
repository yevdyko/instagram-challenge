require 'rails_helper'

# As an existing User
# So that I can post pictures on Pixagram as me
# I want to be able to log in
feature 'User logs in' do
  context 'before signing up' do
    scenario "can see 'Log in' link on the homepage" do
      visit root_path

      expect(page).to have_current_path new_user_registration_path
      expect(page).to have_link t('application.header.login'),
                                href: new_user_session_path
    end

    scenario 'can see invalid login message' do
      user = build :user

      log_in_as user

      expect(page).to have_current_path new_user_registration_path
      expect(page).to have_content t('devise.failure.invalid', authentication_keys: 'Email')
    end

    scenario "can't create a new post without logging in" do
      visit new_post_path

      expect(page).to have_content t('devise.failure.unauthenticated')
      expect(page).to have_current_path new_user_registration_path
    end
  end

  scenario 'enters wrong credentials' do

  end

  context 'after successful login' do
    given(:user) { create :user }

    scenario "can't see 'Log in' link" do
      log_in_as user

      expect(page).to have_current_path authenticated_root_path
      expect(page).to have_content t('devise.sessions.signed_in')
      expect(page).not_to have_link t('application.header.login'),
                                    href: new_user_session_path
    end

    scenario "can see a 'Log out' link" do
      log_in_as user

      expect(page).to have_current_path authenticated_root_path
      expect(page).to have_link t('application.header.logout'),
                                href: destroy_user_session_path
    end
  end
end
