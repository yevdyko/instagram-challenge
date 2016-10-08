require 'rails_helper'

# As a User
# So that I can see what others are posting
# I want to see all pictures in reverse chronological order
feature 'Viewing posts' do
  given(:user)  { create :user }

  scenario 'can see posts in reverse chronological order on the index' do
    old_post = create(:post, created_at: 2.days.ago, user: user)
    new_post = create(:post, created_at: 1.hour.ago, user: user)

    log_in_as user

    expect(new_post.description).to appear_before(old_post.description)
  end

  scenario 'can view an individual post' do
    post = create(:post, user: user)

    log_in_as user
    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click

    expect(page).to have_current_path post_path(post.id)
  end

  # As a User
  # So that I can better appreciate the context of a post
  # I want to see how long ago picture was posted
  scenario 'can see a post with a created date', js: true do
    create(:post, created_at: 12.minutes.ago, user: user)
    create(:post, created_at: 4.hours.ago, user: user)
    create(:post, created_at: 5.years.ago, user: user)

    log_in_as user

    travel_to Time.zone.now do
      expect(page).to have_content '12 minutes ago'
      expect(page).to have_content 'about 4 hours ago'
      expect(page).to have_content '5 years ago'
    end
  end

  # As a User
  # So that I can redirect to the user profile by clicking on the username in caption
  # I want to link username in post's description and user profile page
  scenario 'can redirect to the user profile by clicking on the username in caption' do
    create(:post, user: user)

    log_in_as user
    first('.description-content').click_link user.username

    expect(page).to have_current_path profile_path(user.username)
  end

  # As a User
  # So that I can filter the feed
  # I want to show only posts for the users I'm following
  scenario 'can see only posts of followed users' do
    john = create :user
    mike = create :user
    johns_post = create(:post, user: john)
    mikes_post = create(:post, user: mike)

    log_in_as user
    start_following john

    expect(page).to have_description johns_post
    expect(page).not_to have_description mikes_post
  end

  # As a User
  # So that I can filter the feed
  # I want to show my own posts on the dashboard
  scenario 'can see my own posts' do
    post = create(:post, user: user)

    log_in_as user

    expect(page).to have_description post
  end

  # As a User
  # So that I can find new users to follow
  # I want to browse all other posts
  scenario 'can see all other posts' do
    created_users = create_list(:user, 5)
    created_users.each do |user|
      create(:post, user: user)
    end

    log_in_as user
    find('.user-block-link#browse').click

    expect(page).to have_displayed_posts(5)
  end
end
