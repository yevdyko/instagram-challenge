require 'rails_helper'

feature 'Liking / Unliking posts' do
  given(:user)  { create :user }
  given!(:post) { create :post, user: user }
  background { log_in_as user }

  # As a User
  # So that I can add a 'Like' to the post
  # I want to click a little heart icon under the image
  scenario "can add 'Like' to the post" do
    expect(page).to have_empty_heart_icon
  end

  # As a User
  # So that once I've liked a post
  # I want to see my username added to the post's list of likers
  scenario "can see username added to the post's list of likers" do
    expect(find('.post-likes')).to_not have_username user
    add_like post
    expect(find('.post-likes')).to have_username user
  end

  # As a User
  # So that I can revoke my decision
  # I want to unlike a post by clicking the button again
  scenario 'can unlike a post' do
    add_like post
    expect(find('.post-likes')).to have_username user
    add_unlike post
    expect(find('.post-likes')).to_not have_username user
  end

  # As a User
  # So that once I've liked a post
  # I want to see the heart icon turn solid upon clicking it
  scenario 'can see the heart turn solid red upon liking' do
    expect(page).to have_empty_heart_icon
    add_like post
    expect(page).to have_solid_heart_icon
  end

  # As a User
  # So that a post has more than or equal to 4 likes
  # I want to see the number of likes
  context 'when a post has more than or equal to 4 likes' do
    scenario 'can see the number of likes' do
      created_users = create_list(:user, 4)

      created_users.each do |user|
        log_out_direct
        log_in_as user
        visit browse_posts_path
        add_like post
      end

      expect(find('.post-likes')).to have_content '4 likes'
    end
  end

  # As a User
  # So that I can redirect from the list of likes to my profile
  # I want to link my profile to my username on the list of likes
  scenario 'can redirect from the list of likes to my profile' do
    visit root_path

    add_like post
    first('.post-likes').click_link user.username

    expect(page).to have_current_path profile_path(user.username)
  end
end
