require 'rails_helper'

feature 'Profiles' do
  given(:user)      { create :user }
  given(:user_two)  { create :user }
  given!(:post)     { create :post, user: user }
  given!(:post_two) { create :post, user: user_two }

  background do
    log_in_as user
    first('.username').click_link user.username
  end

  context 'viewing user profiles' do

    # As a User
    # So that I can visit a profile page
    # I want to see the username in the URL
    scenario 'visiting a profile page shows the username in the URL' do
      expect(page.current_path).to eq profile_path(user.username)
    end

    # As a User
    # So that I can visit a profile page
    # I want to see only the specified user's posts
    scenario "a profile page only shows the specified user's posts" do
      expect(page).to have_content post.description
      expect(page).not_to have_content post_two.description
    end
  end

  context 'editing user profiles' do

    # As a User
    # So that I can visit a edit profile page
    # I want to see the edit profile route
    scenario 'visiting the Edit profile page shows the edit profile route' do
      click_link 'Edit Profile'
      expect(page.current_path).to eq edit_profile_path(user.username)
    end

    # As a User
    # So that I can change my own profile details
    # I want to edit my profile
    scenario 'can change my own profile details' do
      click_link 'Edit Profile'
      attach_file('user_avatar', 'spec/files/images/avatar.jpg')
      fill_in 'user_bio', with: user.bio
      click_button 'Update Profile'
      expect(page.current_path).to eq profile_path(user.username)
      expect(page).to have_css "img[src*='avatar']"
      expect(page).to have_content user.bio
    end
  end
end
