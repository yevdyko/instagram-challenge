require 'rails_helper'

# As a User
# So that I can see only 20 comments at a time
# I want to paginate comments
feature 'Paginating comments' do
  given(:user) { create :user }

  scenario 'with less than 20 comments' do
    create(
      :post,
      :with_comments,
      comments_count: 10,
      user: user
    )

    log_in_as user

    expect(page).to have_displayed_comments(10)
    expect(page).to_not have_comments_pagination
  end

  scenario 'viewing only 20 comments at a time' do
    create(
      :post,
      :with_comments,
      comments_count: 22,
      user: user
    )

    log_in_as user

    expect(page).to have_displayed_comments(20)
  end

  scenario 'viewing all comments' do
    create(
      :post,
      :with_comments,
      comments_count: 25,
      user: user
    )

    log_in_as user
    click_link t('comments.pagination', count: 25)

    expect(page).to have_displayed_comments(25)
  end
end
