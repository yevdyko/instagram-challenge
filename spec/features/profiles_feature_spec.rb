require 'rails_helper'

feature 'Profiles' do
  given(:user)      { create :user }
  given(:user_two)  { create :user }
  given!(:post)     { create :post, user: user }
  given!(:post_two) { create :post, user: user_two }
  background { log_in_as user }

  context 'viewing user profiles' do
    background do
      first('.username').click_link user.username
    end

    # As a User
    # So that I can visit a profile page
    # I want to see the username in the URL
    scenario 'visiting a profile page shows the username in the URL' do
      expect(page).to have_current_path profile_path(user.username)
    end

    # As a User
    # So that I can visit a profile page
    # I want to see only the specified user's posts
    scenario "a profile page only shows the specified user's posts" do
      expect(page).to have_description post
      expect(page).not_to have_description post_two
    end
  end

  context 'editing user profiles' do
    background do
      first('.username').click_link user.username
      click_link t('profiles.show.edit')
    end

    # As a User
    # So that I can visit a edit profile page
    # I want to see the edit profile route
    scenario 'visiting the Edit profile page shows the edit profile route' do
      expect(page).to have_current_path edit_profile_path(user.username)
    end

    # As a User
    # So that I can change my own profile details
    # I want to edit my profile
    scenario 'can change my own profile details' do
      attach_file('user_avatar', 'spec/files/images/avatar.jpg')
      fill_in 'user_bio', with: user.bio
      click_button t('profiles.edit.submit')

      expect(page).to have_current_path profile_path(user.username)
      expect(page).to have_image 'avatar'
      expect(page).to have_bio user
      expect(page).to have_content t('profiles.update.notice')
    end

    scenario "can't update profile details with invalid content type" do
      attach_file('user_avatar', 'spec/files/test.zip')
      click_button t('profiles.edit.submit')

      expect(page).to have_errors_messages
    end

    # As a User
    # So that I can only change my own profile details
    # I want to prevent other users from editing my profile
    context "can't edit a profile that doesn't belong to you" do
      scenario "when visiting another user's profile" do
        visit root_path

        find(:xpath, "//a[contains(@href,'/#{user_two.username}')]", match: :first).click

        expect(page).to_not have_content t('profiles.show.edit')
      end

      scenario 'when the url path is directly visited' do
        visit "/#{user_two.username}/edit"

        expect(page).to have_current_path root_path
        expect(page).to have_content t('profiles.owned_profile.alert')
      end
    end
  end
end
