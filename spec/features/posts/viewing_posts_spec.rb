require 'rails_helper'

# As a User
# So that I can see what others are posting
# I want to see all pictures in reverse chronological order
feature 'Viewing posts' do
  given(:user)  { create :user }

  scenario 'can see posts in reverse chronological order on the index' do
    old_post = create(:post, created_at: 2.days.ago)
    new_post = create(:post, created_at: 1.hour.ago)

    visit root_path

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

    visit root_path

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
end
