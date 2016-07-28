require 'rails_helper'

feature 'Liking posts' do
  given(:user)  { create :user }
  given!(:post) { create :post, user: user }

  background do
    log_in_as user
  end

  # As a User
  # So that I can add a ‘Like’ to the post
  # I want to click a little heart icon under the image
  scenario "can add 'Like' to the post" do
    visit root_path
    expect(page).to have_css 'a.glyphicon-heart-empty'
  end

  # As a User
  # So that once I’ve liked a post
  # I want to see my username added to the post’s list of likers
  scenario "can see username added to the post's list of likers" do
    visit root_path
    expect(find('.likes')).to_not have_content user.username
    click_link "like_#{post.id}"
    expect(find('.likes')).to have_content user.username
  end
end
