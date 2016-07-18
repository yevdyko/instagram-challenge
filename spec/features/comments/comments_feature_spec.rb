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
      expect(page).to have_css ".comments#{text.id}", text: "#{message.thoughts}"
    end
  end

  context 'deleting comments' do
    scenario 'can delete a comment on an existing post' do
      message = create :comment
      write_comment_with message
      expect(page).to have_content "#{message.thoughts}"
      delete_comment
      expect(page).to_not have_content "#{message.thoughts}"
      expect(page).to have_content 'Comment deleted successfully.'
    end
  end
end
