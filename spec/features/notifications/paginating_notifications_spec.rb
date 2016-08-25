require 'rails_helper'

# As a User
# So that I can see only 20 notifications at a time in the index view
# I want to paginate notifications
feature 'Paginating notifications' do
  given(:user)  { create :user }
  given!(:post) { create :post }
  given!(:notified_by_user) { create :user }

  scenario 'with less than one page of posts', js: true do
    create_list(:notification,
                10,
                post: post,
                user: user,
                notified_by: notified_by_user)

    log_in_as user

    visit notifications_path

    expect(page).to have_displayed_notifications(10)
    expect(page).to_not have_paginator_link
  end

  scenario 'viewing the first page of notifications' do
    create_list(:notification,
                24,
                post: post,
                user: user,
                notified_by: notified_by_user)

    log_in_as user

    visit notifications_path

    expect(page).to have_displayed_notifications(20)
  end

  scenario 'paginating through the notifications' do
    create_list(:notification,
                24,
                post: post,
                user: user,
                notified_by: notified_by_user)

    log_in_as user

    visit notifications_path

    click_link t('paginator.link', items: 'notifications')

    expect(page).to have_displayed_notifications(4)
  end
end

