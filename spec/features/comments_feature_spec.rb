require 'rails_helper'

feature 'Comments' do
  given(:user)     { create :user }
  given(:user_two) { create :user }
  given!(:post)    { create :post, user: user }
  given(:message)  { build :comment, user: user, post: post }

  # As a User
  # So that I can let people know my thoughts
  # I want to leave a comment on picture
  context 'creating comments' do
    background do
      log_in_as user
    end

    scenario 'can leave a comment on an existing post' do
      write_comment_with message
      within '#comment' do
        expect(page).to have_css '.username', text: user.username
        expect(page).to have_css '.comment-content', text: message.thoughts
      end
    end
  end

  # As a User
  # So that I can rectify what I originally comment
  # I want to delete my comments
  context 'deleting comments' do
    given!(:message_two) { create :comment, user: user_two, post: post }

    background do
      log_in_as user_two
    end

    scenario 'can delete a comment on an existing post' do
      within '#comment' do
        expect(page).to have_css '.username', text: user_two.username
        expect(page).to have_css '.comment-content', text: message_two.thoughts
      end
      delete_comment
      within '.comments' do
        expect(page).not_to have_css '.comment-content', text: message_two.thoughts
      end
    end

    # As a User
    # So that I can protect comments from deleting by another user
    # I want to delete comments that only belong to me
    context "can't delete a comment not belonging to them" do
      background do
        log_out
        log_in_as user
      end

      scenario 'via the user interface' do
        within '#comment' do
          expect(page).to have_css '.comment-content', text: message_two.thoughts
          expect(page).not_to have_css '.delete-comment', text: 'Delete'
        end
      end

      scenario 'via the URLs' do
        page.driver.submit :delete, "posts/#{post.id}/comments/#{message_two.id}", {}
        expect(page).to have_content "That comment doesn't belong to you!"
        within '#comment' do
          expect(page).to have_css '.comment-content', text: message_two.thoughts
        end
      end
    end
  end
end
