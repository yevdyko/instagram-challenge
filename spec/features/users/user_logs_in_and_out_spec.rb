require 'rails_helper'

# As a User
# So that I can post pictures on Pixagram as me
# I want to log in and out of my account
feature 'User logs in and out' do
  context 'user not logged in and on the homepage' do
    xscenario "should see 'Log in' and 'Sign up' links" do
      visit root_path

      expect(page).to have_link t('application.header.login'),
                                href: new_user_session_path
      expect(page).to have_link t('application.header.signup'),
                                href: new_user_registration_path
    end

    scenario "should not see a 'Log out' link" do
      visit root_path

      expect(page).not_to have_link t('application.header.logout'),
                                    href: destroy_user_session_path
    end

    scenario 'cannot create a new post without logging in' do
      visit new_post_path

      expect(page).to have_content t('devise.failure.unauthenticated')
    end
  end

  context 'user logged in on the homepage' do
    given(:user) { create :user }
    background { log_in_as user }

    scenario "should not see 'Log in' and 'Sign up' links" do
      expect(current_path).to eq root_path
      expect(page).to have_content t('devise.sessions.signed_in')
      expect(page).not_to have_link t('application.header.login'),
                                    href: new_user_session_path
      expect(page).not_to have_link t('application.header.signup'),
                                    href: new_user_registration_path
    end

    scenario "should see a 'Log out' link" do
      expect(current_path).to eq root_path
      expect(page).to have_link t('application.header.logout'),
                                href: destroy_user_session_path
    end

    scenario 'can log out once logged in' do
      log_out

      expect(page).to have_content t('devise.failure.unauthenticated')
    end
  end
end
