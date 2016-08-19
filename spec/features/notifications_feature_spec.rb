require 'rails_helper'

feature 'Notifications' do
  given(:user)     { create :user }
  given(:user_two) { create :user }
  given!(:post)    { create(:post, user: user_two) }
  given!(:comment) { create(:comment, user: user_two, post: post)}

  # As a User
  # So that I can find out when someone comments on my post
  # I want to display the notification count on navbar
  scenario 'can see the number of notifications' do
    log_in_as user

    expect(page).to have_icon_flag
    expect(find('.notification-dropdown')).to have_content 1
  end
end
