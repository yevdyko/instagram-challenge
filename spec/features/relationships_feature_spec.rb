require 'rails_helper'

# As a User
# So that I can keep track of posts only by specific user
# I want to follow and unfollow other users
feature 'Following / Unfollowing users' do
  given(:user) { create :user }
  given(:user_two) { create :user }

  context 'if user is logged in' do
    scenario 'can follow other users', js: true do
      log_in_as user

      visit profile_path(user_two.username)
      click_on t('profiles.show.follow')
      wait_for_ajax

      expect(page).not_to have_link t('profiles.show.follow'),
                                      href: follow_user_path(user_two.username)
      expect(page).to have_link t('profiles.show.following'),
                                  href: unfollow_user_path(user_two.username)
    end

    scenario 'can unfollow other users', js: true do
      log_in_as user

      visit profile_path(user_two.username)
      click_on t('profiles.show.follow')
      wait_for_ajax

      expect(page).not_to have_link t('profiles.show.follow'),
                                      href: follow_user_path(user_two.username)
      expect(page).to have_link t('profiles.show.following'),
                                  href: unfollow_user_path(user_two.username)

      click_on t('profiles.show.following')
      wait_for_ajax

      expect(page).not_to have_link t('profiles.show.following'),
                                      href: unfollow_user_path(user_two.username)
      expect(page).to have_link t('profiles.show.follow'),
                                  href: follow_user_path(user_two.username)
    end
  end
end
