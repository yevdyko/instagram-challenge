require 'rails_helper'

# As a User
# So that I can post pictures on Pixagram as me
# I want to log in and log out of my account
feature 'User can log in and out' do
  context 'user not logged in and on the homepage' do
    scenario "should see a 'Log in' link and a 'Sign up' link" do
      visit root_path

      expect(page).to have_link t('application.header.login'),
                                href: new_user_session_path
      expect(page).to have_link t('application.header.signup'),
                                href: new_user_registration_path
    end

    scenario "should not see 'Log out' link" do
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
    background do
      user = create :user

      log_in_as user
    end

    scenario "should see a 'Log out' link" do
      expect(current_path).to eq root_path
      expect(page).to have_link t('application.header.logout'),
                                href: destroy_user_session_path
    end

    scenario 'can log out once logged in' do
      log_out

      expect(page).to have_content t('devise.sessions.signed_out')
    end

    scenario "should not see a 'Log in' link and a 'Sign up' link" do
      expect(current_path).to eq root_path
      expect(page).to have_content t('devise.sessions.signed_in')
      expect(page).not_to have_link t('application.header.login'),
                                    href: new_user_session_path
      expect(page).not_to have_link t('application.header.signup'),
                                    href: new_user_registration_path
    end
  end
end
