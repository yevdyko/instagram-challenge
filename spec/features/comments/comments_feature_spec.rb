require 'rails_helper'

feature 'Comments' do
  given(:user)      { create :user }
  given(:user_2)    { create :user }
  given(:text)      { create :post, user: user }
  given(:message)   { build :comment, user: user, post: text }
  given(:message_2) { build :comment, user: user_2, post: text }

  # As a User
  # So that I can let people know my thoughts
  # I want to leave a comment on picture
  context 'creating comments' do
    background do
      log_in_as user
    end

    scenario 'can leave a comment on an existing post' do
      write_comment_with message
      user_should_see_username_of user
      user_should_see_comment message
    end
  end

  # As a User
  # So that I can rectify what I originally comment
  # I want to delete my comments
  context 'deleting comments' do
    background do
      log_in_as user_2
      write_comment_with message_2
    end

    scenario 'can delete a comment on an existing post' do
      user_should_see_comment message_2
      user_should_see_username_of user_2
      delete_comment
      user_should_not_see_comment message_2
    end

    # As a User
    # So that I can protect comments from deleting by another user
    # I want to delete comments that only belong to me
    scenario "can't delete a comment not belonging to them" do
      log_out
      log_in_as user
      user_should_see_comment message_2
      user_should_not_see_link 'Delete'
    end

    scenario "can't delete a comment not belonging to them via urls" do
      log_out
      log_in_as user
      page.driver.submit :delete, "posts/4/comments/4", {}
      user_should_see_alert "That comment doesn't belong to you!"
      user_should_see_comment message_2
    end
  end
end
