require 'rails_helper'

module PostHelpers
  def create_post_with(text)
    visit root_path
    click_link 'Create Post'
    attach_file('Image', 'spec/files/images/test.jpg')
    fill_in 'Description', with: text.description
    click_button 'Create Post'
  end

  def edit_post_with(text)
    visit root_path
    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
    click_link 'Edit Post'
    fill_in 'Description', with: text.description
    click_button 'Update Post'
  end

  def delete_post
    visit root_path
    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
    click_link 'Edit Post'
    click_link 'Delete Post'
  end

  def have_displayed_posts(count)
    have_css('.posts .post', count: count)
  end

  def have_pagination_button
    have_css('.paginator')
  end
end
