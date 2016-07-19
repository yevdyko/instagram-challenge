require 'rails_helper'

module CommentHelpers
  def write_comment_with message
    visit root_path
    fill_in "comment[thoughts]", with: message.thoughts, match: :first
    click_button 'New comment', match: :first
  end

  def delete_comment
    visit root_path
    click_link 'Delete'
  end

  def user_should_see_comment message
    within '#comment' do
      expect(page).to have_css '.comment-content', text: message.thoughts
    end
  end

  def user_should_not_see_comment message
    within '.comments' do
      expect(page).not_to have_css '.comment-content', text: message.thoughts
    end
  end

  def user_should_see_username_of user_two
    within '#comment' do
      expect(page).to have_css '.username', text: user_two.username
    end
  end
end
