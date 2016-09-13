require 'rails_helper'

feature 'Viewing user profiles' do
  given(:john) { create :user }
  given(:mike) { create :user }

  # As a User
  # So that I can visit a profile page
  # I want to see the username in the URL
  scenario 'visiting a profile page shows the username in the URL' do
    create(:post, user: john)

    log_in_as john
    first('.username').click_link john.username

    expect(page).to have_current_path profile_path(john.username)
  end

  # As a User
  # So that I can visit a profile page
  # I want to see only the specified user's posts
  scenario "profile page shows only the specified user's posts" do
    johns_post = create(:post, user: john)
    mikes_post = create(:post, user: mike)

    log_in_as mike
    visit browse_posts_path

    expect(page).to have_description johns_post
    expect(page).to have_description mikes_post

    first('.username').click_link john.username

    expect(page).to have_description johns_post
    expect(page).not_to have_description mikes_post
  end

  # As a User
  # So that I can know the user activity
  # I want to see a post count on profile page
  scenario 'can see a post count on profile page' do
    3.times { create(:post, user: john) }

    log_in_as john
    visit profile_path(john.username)

    expect(page).to have_post_count(3)
  end

  context 'can know who is popular' do
    background do
      log_in_as john
      start_following mike
    end

    # As a User
    # So that I can know who is popular
    # I want to see a follower count on profile page
    scenario 'by viewing a follower count on profile page' do
      visit profile_path(mike.username)

      expect(page).to have_follower_count(1)
    end

    # As a User
    # So that I can know who is popular
    # I want to see a following count on profile page
    scenario 'by viewing a following count on profile page' do
      visit profile_path(john.username)

      expect(page).to have_following_count(1)
    end
  end
end
