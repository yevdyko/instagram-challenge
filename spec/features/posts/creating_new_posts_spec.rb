require 'rails_helper'

# As a User
# So that I can let people know what I am doing
# I want to post pictures on Pixagram

# As a User
# So that I can post pictures on Pixagram as me
# I want the posts I create belong to me only
feature 'Creating posts' do
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

  scenario 'can create a new post' do
    create_post_with text

    expect(page).to have_current_path root_path
    expect(page).to have_description text
    expect(page).to have_image 'test'
    expect(page).not_to have_content t('posts.index.empty')
    expect(find('.post-head')).to have_username user
  end

  scenario 'needs to add an image' do
    click_link t('application.header.create_post')
    fill_in 'post_description', with: 'No picture'
    click_button 'Create Post'

    expect(page).to have_content t('posts.create.alert')
    expect(page).to have_content t('errors.messages.blank')
  end
end
