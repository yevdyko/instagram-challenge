require 'rails_helper'

# As a User
# So that I can post pictures on Pixagram as me
# I want to be able to log in
feature 'User logs in' do
  context 'User is not signed up' do
    scenario 'navigates to the homepage' do
      visit root_path

      expect(page).to have_current_path new_user_registration_path
    end

    scenario "can see 'Sign up' fields and 'Log in' link" do
      visit root_path

      expect(page).to have_field t('registration.email')
      expect(page).to have_field t('registration.username')
      expect(page).to have_field t('registration.password')
      expect(page).to have_field t('registration.password_confirmation')
      expect(page).to have_link t('application.header.login'),
                                href: new_user_session_path
    end

    scenario "can't create a new post without logging in" do
      visit new_post_path

      expect(page).to have_current_path new_user_registration_path
    end
  end

  context 'User is logged in successfully' do
    given(:user) { create :user }

    scenario "can't see 'Log in' and 'Sign up' links" do
      log_in_as user

      expect(page).to have_current_path root_path
      expect(page).to have_content t('devise.sessions.signed_in')
      expect(page).not_to have_link t('application.header.login'),
                                    href: new_user_session_path
      expect(page).not_to have_link t('application.header.signup'),
                                    href: new_user_registration_path
    end

    scenario "can see 'Profile' link" do
      log_in_as user

      expect(page).to have_current_path root_path
      expect(page).to have_profile_link
    end
  end

  def have_profile_link
    have_selector(:css, "a#profile[href='/#{user.username}']")
  end
end
