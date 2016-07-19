require 'rails_helper'

feature 'Comments' do
  given(:user)     { create :user }
  given(:user_two) { create(:user, username: 'paulsmith', email: 'paulsmith@email.com', id: 2) }
  given(:text)     { build :post }
  given(:message)  { build :comment }

  background do
    log_in_as user
    create_post_with text
  end

  # As a User
  # So that I can let people know my thoughts
  # I want to leave a comment on picture
  context 'creating comments' do
    scenario 'can leave a comment on an existing post' do
      write_comment_with message
      user_should_see_username_of user
      user_should_see_comment message
    end
  end

  # As a User
  # So that I can rectify what I originally comment
  # I want to delete my comment
  context 'deleting comments' do
    background do
      log_out
      log_in_as user_two
    end

    scenario 'can delete a comment on an existing post' do
      write_comment_with message
      user_should_see_comment message
      user_should_see_username_of user_two
      delete_comment
      user_should_not_see_comment message
    end
  end
end
