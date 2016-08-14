require 'rails_helper'

# As a User
# So that I can see only 12 posts at a time
# I want to paginate posts
feature 'Paginating posts' do
  given(:user) { create :user }

  scenario 'with less than one page of posts', js: true do
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
    click_link t('paginator.button')

    expect(page).to have_displayed_posts(2)
  end
end
