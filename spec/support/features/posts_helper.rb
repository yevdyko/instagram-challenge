module PostsHelpers
  def create_post_with(text)
    visit root_path
    click_link t('application.header.create_post')
    attach_file('post_image', 'spec/files/images/test.jpg')
    fill_in 'post_description', with: text.description
    click_button 'Create Post'
  end

  def edit_post_with(text)
    visit root_path
    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
    click_link t('posts.show.edit')
    fill_in 'post_description', with: text.description
    click_button 'Update Post'
  end

  def delete_post
    visit root_path
    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
    click_link t('posts.show.edit')
    click_link t('posts.edit.delete.link')
  end

  def have_image(name)
    have_css("img[src*='#{name}']")
  end

  def have_description(text)
    have_css('.description-text', text: text.description)
  end

  def have_displayed_posts(count)
    have_css('.posts .post', count: count)
  end

  def have_pagination_button
    have_css('.paginator')
  end
end
