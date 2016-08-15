require 'rails_helper'

# As a User
# So that I can rectify what I originally post
# I want to edit my posts
feature 'Updating posts' do
  given(:user)      { create :user }
  given(:user_two)  { create :user }
  given!(:post)     { create(:post, user: user) }
  given!(:post_two) { create(:post, user: user_two) }
  background { log_in_as user }

  scenario 'can edit a post as an owner' do
    other_text = build(:post, description: 'My edited post', user: user)

    edit_post_with other_text

    expect(page).to have_current_path root_path
    expect(page).to have_description other_text
    expect(page).to have_content t('posts.update.notice')
  end

  context "can't edit a post that doesn't belong to you" do
    scenario 'when visiting the show page' do
      find(:xpath, "//a[contains(@href,'posts/#{post_two.id}')]", match: :first).click

      expect(page).to_not have_content t('posts.show.edit')
    end

    scenario 'when the url path is directly visited' do
      visit "/posts/#{post_two.id}/edit"

      expect(page).to have_current_path root_path
      expect(page).to have_content t('posts.owned_post.alert')
    end
  end

  scenario "can't update a post without an attached image" do
    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
    click_link t('posts.show.edit')
    attach_file('post_image', 'spec/files/test.zip')
    click_button 'Update Post'

    expect(page).to have_content t('posts.update.alert')
  end
end