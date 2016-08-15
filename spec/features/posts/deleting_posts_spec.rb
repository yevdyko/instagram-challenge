require 'rails_helper'

# As a User
# So that I can rectify what I originally post
# I want to delete my posts
feature 'Deleting posts' do
  given(:user)  { create :user }
  given!(:post) { create(:post, user: user) }

  scenario 'can remove a post' do
    log_in_as user
    delete_post

    expect(page).not_to have_description post
    expect(page).to have_content t('posts.destroy.notice')
  end
end
