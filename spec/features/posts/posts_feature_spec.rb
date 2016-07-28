require 'rails_helper'

feature 'Posts' do
  given(:user)  { create :user }
  given!(:text) { build :post }

  background do
    log_in_as user
  end

  context 'no posts have been added' do
    scenario 'displays a link to add a post' do
      visit root_path
      expect(page).to have_link 'Create Post'
    end

    scenario 'displays a message that there are no posts' do
      visit root_path
      expect(page).to have_content 'There are no posts'
    end
  end

  # As a User
  # So that I can let people know what I am doing
  # I want to post pictures on Pixagram

  # As a User
  # So that I can post pictures on Pixagram as me
  # I want the posts I create belong to me only
  context 'creating posts' do
    scenario 'can create a new post' do
      create_post_with text
      expect(current_path).to eq root_path
      expect(page).to have_content "#{text.description}"
      expect(page).to have_css "img[src*='test']"
      expect(page).not_to have_content 'There are no posts'
      expect(page).to have_content user.username
    end

    scenario 'needs to add an image' do
      visit root_path
      click_link 'Create Post'
      fill_in 'Description', with: 'No picture'
      click_button 'Create Post'
      expect(page).to have_content 'Warning! You need an image to post here!'
      expect(page).to have_content "can't be blank"
    end
  end

  # As a User
  # So that I can see what others are posting
  # I want to see all pictures in reverse chronological order
  context 'viewing posts' do
    scenario 'can see posts in reverse chronological order on the index' do
      other_text = build(:post, description: 'My second peep')
      create_post_with text
      create_post_with other_text
      within('.description', match: :first) do
        expect(page).to have_content other_text.description
      end
    end

    scenario 'can view an individual post' do
      post = create(:post, user: user)
      visit root_path
      find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
      expect(page.current_path).to eq(post_path(post.id))
    end

    # As a User
    # So that I can better appreciate the context of a post
    # I want to see how long ago picture was posted
    scenario 'can see a post with a created date', js: true do
      text_1 = create(:post, created_at: 12.minutes.ago, user: user)
      text_2 = create(:post, created_at: 4.hours.ago, user: user)
      text_3 = create(:post, created_at: 5.years.ago, user: user)
      visit root_path
      travel_to Time.now do
        expect(page).to have_content '12 minutes ago'
        expect(page).to have_content 'about 4 hours ago'
        expect(page).to have_content '5 years ago'
      end
    end
  end

  # As a User
  # So that I can rectify what I originally post
  # I want to edit my posts
  context 'updating posts' do
    given(:user_two)  { create :user }
    given!(:post)     { create(:post, user: user) }
    given!(:post_two) { create(:post, user: user_two) }

    scenario 'can edit a post as an owner' do
      other_text = build(:post, description: 'My edited post', user: user)
      edit_post_with other_text
      expect(current_path).to eq root_path
      expect(page).to have_content other_text.description
      expect(page).to have_content 'Post updated successfully.'
    end

    context "can't edit a post that doesn't belong to you" do
      scenario 'when visiting the show page' do
        log_out
        log_in_as user_two
        find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
        expect(page).to_not have_content 'Edit Post'
      end

      scenario 'when the url path is directly visited' do
        visit "/posts/#{post_two.id}/edit"
        expect(page.current_path).to eq root_path
        expect(page).to have_content "That post doesn't belong to you!"
      end
    end

    scenario "can't update a post without an attached image" do
      visit root_path
      find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
      click_link 'Edit Post'
      attach_file('Image', 'spec/files/test.zip')
      click_button 'Update Post'
      expect(page).to have_content 'Update failed. Please check the form.'
    end
  end

  # As a User
  # So that I can rectify what I originally post
  # I want to delete my posts
  context 'deleting posts' do
    given!(:post) { create(:post, user: user) }

    scenario 'can remove a post' do
      delete_post
      expect(page).not_to have_content text.description
      expect(page).to have_content 'Post deleted successfully'
    end
  end
end
