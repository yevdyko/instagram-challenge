require 'rails_helper'

feature 'Posts' do
  given(:user)  { create :user }
  given!(:text) { build :post }
  background { log_in_as user }

  context 'no posts have been added' do
    scenario 'displays a link to add a post' do
      visit root_path

      expect(page).to have_link t('application.header.create_post'),
                                href: new_post_path
    end

    scenario 'displays a message that there are no posts' do
      visit root_path

      expect(page).to have_content t('posts.index.empty')
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

      expect(page).to have_current_path root_path
      expect(page).to have_description text
      expect(page).to have_image 'test'
      expect(page).not_to have_content t('posts.index.empty')
      expect(find('.post-head')).to have_username user
    end

    scenario 'needs to add an image' do
      visit root_path

      click_link t('application.header.create_post')
      fill_in 'post_description', with: 'No picture'
      click_button 'Create Post'

      expect(page).to have_content t('posts.create.alert')
      expect(page).to have_content t('errors.messages.blank')
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
        expect(page).to have_description other_text
      end
    end

    scenario 'can view an individual post' do
      post = create(:post, user: user)

      visit root_path
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

      expect(page).to have_current_path root_path
      expect(page).to have_description other_text
      expect(page).to have_content t('posts.update.notice')
    end

    context "can't edit a post that doesn't belong to you" do
      scenario 'when visiting the show page' do
        visit root_path

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
      visit root_path

      find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
      click_link t('posts.show.edit')
      attach_file('post_image', 'spec/files/test.zip')
      click_button 'Update Post'

      expect(page).to have_content t('posts.update.alert')
    end
  end

  # As a User
  # So that I can rectify what I originally post
  # I want to delete my posts
  context 'deleting posts' do
    given!(:post) { create(:post, user: user) }

    scenario 'can remove a post' do
      delete_post

      expect(page).not_to have_description text
      expect(page).to have_content t('posts.destroy.notice')
    end
  end

  # As a User
  # So that I can see only 12 posts at a time
  # I want to paginate posts
  context 'paginating posts' do
    scenario 'less than one page of posts', js: true do
      create_list(:post, 10, user: user)

      visit root_path

      expect(page).to have_displayed_posts(10)
      expect(page).to_not have_pagination_button
    end

    scenario 'viewing the first page of posts' do
      create_list(:post, 14, user: user)

      visit root_path

      expect(page).to have_displayed_posts(12)
    end

    scenario 'paginating through the posts' do
      create_list(:post, 14, user: user)

      visit root_path
      click_link 'Load more'

      expect(page).to have_displayed_posts(2)
    end
  end
end
