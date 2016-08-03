require 'rails_helper'

feature 'Liking posts' do
  given(:user)  { create :user }
  given!(:post) { create :post, user: user }

  # As a User
  # So that I can add a 'Like' to the post
  # I want to click a little heart icon under the image
  scenario "can add 'Like' to the post" do
    log_in_as user
    expect(page).to have_css 'a.glyphicon-heart-empty'
  end

  # As a User
  # So that once I've liked a post
  # I want to see my username added to the post's list of likers
  scenario "can see username added to the post's list of likers" do
    log_in_as user
    expect(find('.likes')).to_not have_content user.username
    click_link "like_#{post.id}"
    expect(find('.likes')).to have_content user.username
  end

  # As a User
  # So that I can revoke my decision
  # I want to unlike a post by clicking the button again
  scenario 'can unlike a post' do
    log_in_as user
    click_link "like_#{post.id}"
    expect(find('.likes')).to have_content user.username
    click_link "like_#{post.id}"
    expect(find('.likes')).to_not have_content user.username
  end

  # As a User
  # So that once I've liked a post
  # I want to see the heart icon turn solid upon clicking it
  scenario 'can see the heart turn solid red upon liking' do
    log_in_as user
    expect(page).to have_css('a.glyphicon-heart-empty')
    click_link "like_#{post.id}"
    expect(page).to have_css('a.glyphicon-heart')
  end

  # As a User
  # So that a post has more than or equal to 4 likes
  # I want to see the number of likes
  context 'when a post has more than or equal to 4 likes' do
    scenario 'can see the number of likes' do
      created_users = create_list(:user, 4)
      created_users.each do |user|
        log_in_as user
        click_link "like_#{post.id}"
        log_out
      end
      expect(find('.likes')).to have_content '4 likes'
    end
  end

  # As a User
  # So that I can redirect from the list of likes to my profile
  # I want to link my profile to my username on the list of likes
  scenario 'can redirect from the list of likes to my profile' do
    user_two = create :user
    log_in_as user_two
    click_link "like_#{post.id}"
    first('.likes').click_link user_two.username
    expect(page.current_path).to eq profile_path(user_two.username)
  end
end
