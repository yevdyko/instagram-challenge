require 'rails_helper'

# As a User
# So that I can let people know my thoughts
# I want to leave a comment on picture
feature 'Creating comments' do
  scenario 'can leave a comment on an existing post' do
    user = create :user
    post = create(:post, user: user)
    message = create(:comment, user: user, post: post)

    log_in_as user
    write_comment_with message

    within '.comments' do
      expect(page).to have_username user
      expect(page).to have_comment message
    end
  end
end
