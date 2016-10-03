require 'rails_helper'

# As a User
# So that I can see only 20 comments at a time
# I want to paginate comments
feature 'Paginating comments' do
  given(:user) { create :user }

  scenario 'with less than 4 comments' do
    create(
      :post,
      :with_comments,
      comments_count: 3,
      user: user
    )

    log_in_as user

    expect(page).to have_displayed_comments(3)
    expect(page).to_not have_comments_pagination
  end

  scenario 'viewing only 4 comments at a time' do
    create(
      :post,
      :with_comments,
      comments_count: 15,
      user: user
    )

    log_in_as user

    expect(page).to have_displayed_comments(4)
  end

  scenario 'viewing all comments' do
    create(
      :post,
      :with_comments,
      comments_count: 15,
      user: user
    )

    log_in_as user
    click_link t('comments.pagination', count: 15)

    expect(page).to have_displayed_comments(15)
  end
end
