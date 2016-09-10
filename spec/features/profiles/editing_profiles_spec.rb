require 'rails_helper'

feature 'Editing user profiles' do
  given(:user) { create :user }
  given!(:post) { create(:post, user: user) }

  background do
    log_in_as user
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
      john = create :user
      johns_post = create(:post, user: john)

      visit browse_posts_path
      find(:xpath, "//a[contains(@href,'/#{john.username}')]", match: :first).click

      expect(page).to_not have_content t('profiles.show.edit')
    end

    scenario 'when the url path is directly visited' do
      john = create :user

      visit "/#{john.username}/edit"

      expect(page).to have_current_path root_path
      expect(page).to have_content t('profiles.owned_profile.alert')
    end
  end
end
