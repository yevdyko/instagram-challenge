require 'rails_helper'

feature 'Posts' do
  given(:user) { create :user }
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
      expect(page).to have_content "#{user.username}"
    end

    scenario 'user needs to add an image' do
      visit root_path
      click_link 'Create Post'
      fill_in 'Description', with: 'No picture'
      click_button 'Create Post'
      expect(page).to have_content 'Warning! You need an image to post here!'
    end
  end

  context 'viewing posts' do
    scenario 'user can see a post on the index' do
      create_post_with text
      expect(page).to have_content "#{text.description}"
    end

    scenario 'user can view an individual post' do
      create_post_with text
      visit root_path
      find(:xpath, "//a[contains(@href,'posts/5')]").click
      expect(page.current_path).to eq(post_path(5))
    end
  end

  # As a User
  # So that I can rectify what I originally post
  # I want to edit my posts
  context 'updating posts' do
    scenario 'user can edit a post' do
      other_text = build(:post, description: 'My edited post')
      create_post_with text
      edit_post_with other_text
      expect(current_path).to eq root_path
      expect(page).to have_content "#{other_text.description}"
    end
  end

  # As a User
  # So that I can rectify what I originally post
  # I want to delete my posts
  context 'deleting posts' do
    scenario 'user can remove a post' do
      create_post_with text
      delete_post
      expect(page).not_to have_content "#{text.description}"
      expect(page).to have_content 'Post deleted successfully'
    end
  end

  context 'adding pictures' do
    scenario 'user can add a picture when he creates a post' do
      create_post_with text
      expect(page).to have_css "img[src*='test.jpg']"
    end
  end
end
