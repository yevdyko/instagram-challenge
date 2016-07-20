require 'rails_helper'

feature 'Comments' do
  given(:user)     { create :user }
  given(:user_two) do
    create(:user, username: 'paulsmith', email: 'paulsmith@email.com', id: 2)
  end
  given(:text)     { build :post }
  given(:message)  { build :comment }

  # As a User
  # So that I can let people know my thoughts
  # I want to leave a comment on picture
  context 'creating comments' do
    scenario 'can leave a comment on an existing post' do
      log_in_as user
      create_post_with text
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
      log_in_as user
      create_post_with text
      log_out
      log_in_as user_two
      write_comment_with message
    end

    scenario 'can delete a comment on an existing post' do
      user_should_see_comment message
      user_should_see_username_of user_two
      delete_comment
      user_should_not_see_comment message
    end

    # As a User
    # So that I can protect comments from deleting by another user
    # I want to delete comments that only belong to me
    scenario "can't delete a comment not belonging to them" do
      log_out
      log_in_as user
      expect(page).to have_content message.thoughts
      expect(page).to_not have_content 'Delete'
    end

    scenario "can't delete a comment not belonging to them via urls" do
      log_out
      log_in_as user
      page.driver.submit :delete, "posts/4/comments/4", {}
      expect(page).to have_content "That comment doesn't belong to you!"
      expect(page).to have_content message.thoughts
    end
  end
end
