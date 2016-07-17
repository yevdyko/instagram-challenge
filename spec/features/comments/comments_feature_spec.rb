require 'rails_helper'

feature 'Comments' do
  given(:user) { create :user }
  given!(:text) { build :post }

  background do
    log_in_as user
    create_post_with text
  end

  # As a User
  # So that I can let people know my thoughts
  # I want to leave a comment on picture
  context 'creating comments' do
    scenario 'can leave a comment on an existing post' do
      message = create :comment
      write_comment_with message
      expect(page).to have_content "#{message.thoughts}"
    end
  end
end
