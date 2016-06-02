require 'rails_helper'

module CommentHelpers
  def write_comment_with message
    visit root_path
    fill_in "comment[thoughts]", with: message.thoughts, match: :first
    click_button 'New comment', match: :first
  end
end
