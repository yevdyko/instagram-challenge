require 'rails_helper'

feature 'Viewing notifications' do
  given(:user)  { create :user }
  given!(:post) { create(:post, user: user) }
  given(:notified_by_user) { create :user }
  background { log_in_as user }

  context 'no notifications have been added' do
    scenario 'displays a message that there are no notifications' do
      visit notifications_path

      expect(page).to have_content t('notifications.index.empty')
    end
  end

  context 'when notifications have been added' do
    background do
      create_list(:notification,
                  10,
                  post: post,
                  user: user,
                  notified_by: notified_by_user)

      visit notifications_path
    end

    # As a User
    # So that I can find out when someone has reacted to my post
    # I want to display the notification count on navbar
    scenario 'can see the number of notifications on navbar' do
      expect(page).to have_notification_count '10'
    end

    # As a User
    # So that I can see only unread notifications in the navbar
    # I want to mark visited notifications as read
    scenario 'can see only unread notifications in the navbar' do
      6.times do
        click_link t('notifications.item.comment',
                     username: notified_by_user.username),
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

    # As a User
    # So that I can better appreciate the context of a notification
    # I want to see how long ago notification was created
    scenario 'can see a notification with a created date', js: true do
      different_times = [12.minutes.ago, 4.hours.ago, 5.years.ago]
      different_times.each do |time|
        create(:notification,
               user: user,
               post: post,
               notified_by: notified_by_user,
               created_at: time)
      end

      visit notifications_path

      travel_to Time.zone.now do
        expect(page).to have_content '12 minutes ago'
        expect(page).to have_content 'about 4 hours ago'
        expect(page).to have_content '5 years ago'
      end
    end
  end

  # As a User
  # So that I can find out when someone comments on my post
  # I want to see notifications
  context 'can see notifications' do
    scenario "when someone comments on user's posts" do
      create(:notification,
             post: post,
             user: user,
             notified_by: notified_by_user,
             notice_type: 'comment')

      visit notifications_path

      expect(page).to have_notice_type 'comment'
    end

    # As a User
    # So that I can find out when someone likes my post
    # I want to see notifications
    scenario "when someone likes user's posts" do
      create(:notification,
             post: post,
             user: user,
             notified_by: notified_by_user,
             notice_type: 'like')

      visit notifications_path

      expect(page).to have_notice_type 'like'
    end
  end
end
