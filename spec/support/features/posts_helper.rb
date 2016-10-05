module PostsHelpers
  def create_post_with(text)
    visit root_path

    if Capybara.javascript_driver == :selenium
      find('.user-block-link#profile').click
    else
      find('.user-block-link#profile').trigger('click')
    end

    find('.btn-options').click
    click_link t('application.modal.create_post')
    attach_file('post_image', Rails.root + 'spec/files/images/test.jpg')
    fill_in 'post_description', with: text.description
    click_button 'Create Post'
  end

  def edit_post_with(text)
    visit root_path
    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
    within '.edit-links' do
      click_link t('posts.show.edit')
    end
    fill_in 'post_description', with: text.description
    click_button 'Update Post'
  end

  def delete_post
    visit root_path
    find(:xpath, "//a[contains(@href,'posts/#{post.id}')]", match: :first).click
    within '.edit-links' do
      click_link t('posts.show.edit')
    end
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

  def have_posts_pagination
    have_css('.posts-pagination')
  end

  def start_following(user)
    visit profile_path(user.username)
    click_on t('profiles.show.follow')
  end
end
