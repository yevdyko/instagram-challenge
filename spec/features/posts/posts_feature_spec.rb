require 'rails_helper'

feature 'Posts' do
  context 'no posts have been added' do
    background do
      user = create :user
      log_in_as user
    end

    scenario 'displays a link to add a post' do
      visit root_path
      expect(page).to have_link 'Create Post'
    end

    scenario 'displays a message that there are no posts' do
      visit root_path
      expect(page).to have_content 'There are no posts'
    end
  end

  context 'posts have been added' do
    background do
      user = create :user
      log_in_as user
    end

    scenario 'displays a description to posts on the index' do
      text = create :post
      create_post_with text
      save_and_open_page
      expect(page).to have_content "#{text.description}"
      expect(page).not_to have_content 'There are no posts'
    end
  end

  # As a User
  # So that I can let people know what I am doing
  # I want to post pictures on Instagram
  context 'creating posts' do
    background do
      user = create :user
      log_in_as user
    end

    scenario 'prompts user to fill out a form, then display new posts' do
      text = create :post
      create_post_with text
      expect(page).to have_content "#{text.description}"
      expect(current_path).to eq posts_path
    end

    scenario 'user needs to add an image' do
      visit root_path
      click_link 'Create Post'
      fill_in 'Description', with: 'No picture'
      click_button 'Create Post'
      expect(page).to have_content "can't be blank"
    end
  end

  context 'viewing posts' do
    background do
      user = create :user
      log_in_as user
    end

    scenario 'lets a user to view a post' do
      text = create :post
      create_post_with text
      visit posts_path
      expect(page).to have_content "#{text.description}"
    end
  end

  # As a User
  # So that I can rectify what I originally post
  # I want to edit my posts
  context 'updating posts' do
    background do
      user = create :user
      log_in_as user
    end

    scenario 'user can edit a post' do
      text = create :post
      create_post_with text
      edit_post_with('My edited post')
      expect(page).to have_content('My edited post')
      expect(current_path).to eq root_path
    end
  end

  # As a User
  # So that I can rectify what I originally post
  # I want to delete my posts
  context 'deleting posts' do
    background do
      user = create :user
      log_in_as user
    end

    scenario 'user can remove a post' do
      text = create :post
      create_post_with text
      save_and_open_page
      delete_post
      expect(page).not_to have_content("#{text.description}")
      expect(page).to have_content('Post deleted successfully')
    end
  end

  context 'adding pictures' do
    background do
      user = create :user
      log_in_as user
    end

    scenario 'user can add a picture when he creates a post' do
      text = create :post
      create_post_with text
      expect(page).to have_css("img[src*='test.jpg']")
    end
  end
end
