require 'rails_helper'

feature 'Notifications' do
  given(:user)     { create :user }
  given(:user_two) { create :user }
  given!(:post)    { create(:post, user: user) }

  background do
    built_messages = build_list(:comment, 10, post: post, user: user_two)

    log_in_as user_two

    built_messages.each do |message|
      write_comment_with message
    end

    log_out
    log_in_as user
  end

  # As a User
  # So that I can find out when someone comments on my post
  # I want to display the notification count on navbar
  scenario 'can see the number of notifications on navbar' do
    expect(page).to have_icon_flag
    expect(page).to have_notification_count '10'
  end

  # As a User
  # So that I can see only unread notifications in the navbar
  # I want to mark visited notifications as read
  scenario 'can see only unread notifications in the navbar' do
    6.times do
      click_link t('notifications.dropdown-menu.item',
                   username: user_two.username,
                   notice_type: 'comment'),
                   match: :first
    end

    expect(page).to have_current_path post_path(post)
    expect(page).to have_notification_count '4'
  end

  # As a User
  # So that I can see the limited amount of notifications in the navbar
  # I want to show only the last 5 unread notifications
  scenario 'can see only the last 5 unread notifications in the navbar' do
    expect(page).to have_unread_notifications(5)
  end

  # As a User
  # So that I can see all notifications in the index view
  # I want to navigate to the notification index page via the top dropdown menu
  scenario 'can see all notifications in the index view' do
    click_link t('notifications.dropdown-menu.link')

    expect(page).to have_current_path notifications_path
    expect(page).to have_displayed_notifications(10)
  end
end
