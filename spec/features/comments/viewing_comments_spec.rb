require 'rails_helper'

# As a User
# So that I can see a profile of user who commented on my post
# I want to link user's profile to the username in comment
feature 'Viewing comments' do
  scenario 'can see a profile of user who commented on my post' do
    john = create :user
    johns_post = create(:post, user: john)
    mike = create :user

    create(
      :comment,
      user: mike,
      post: johns_post
    )

    log_in_as john
    first('.comment').click_link mike.username

    expect(page).to have_current_path profile_path(mike.username)
  end
end
