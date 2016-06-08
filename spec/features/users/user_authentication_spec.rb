require 'rails_helper'

# As a User
# So that I can post pictures on Instagram as me
# I want to log in and log out of my account
feature 'User can log in and out' do
  context 'user not logged in and on the homepage' do
    scenario "should see a 'Log in' link and a 'Sign up' link" do
      visit root_path
      expect(page).to have_link 'Log in'
      expect(page).to have_link 'Sign up'
    end

    scenario "should not see 'Log out' link" do
      visit root_path
      expect(page).not_to have_link 'Log out'
    end
  end

  context 'user logged in on the homepage' do
    background do
      user = create :user
      log_in_as user
    end

    scenario "should see a 'Log out' link" do
      expect(current_path).to eq root_path
      expect(page).to have_link 'Log out'
    end

    scenario "should not see a 'Log in' link and a 'Sign up' link" do
      expect(current_path).to eq root_path
      expect(page).not_to have_link 'Log in'
      expect(page).not_to have_link 'Sign up'
    end
  end
end
