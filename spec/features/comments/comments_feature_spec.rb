require 'rails_helper'

# As a User
# So that I can let people know my thoughts
# I want to leave a comment on picture
feature 'Comments' do
  background do
    user = create :user
    log_in_as user

    text = create :post
    create_post_with text
  end

  scenario 'user can leave a comment on an existing post' do
    message = create :comment

    write_comment_with message
    expect(page).to have_content "#{message.thoughts}"
  end
end
