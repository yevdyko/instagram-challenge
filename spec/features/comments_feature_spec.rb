require 'rails_helper'

feature 'Comments' do
  given(:user)     { create :user }
  given!(:post)    { create :post, user: user }
  given(:message)  { build :comment, user: user, post: post }
  background { log_in_as user }

  # As a User
  # So that I can let people know my thoughts
  # I want to leave a comment on picture
  context 'creating comments' do
    scenario 'can leave a comment on an existing post' do
      write_comment_with message

      within '.comments' do
        expect(page).to have_username user
        expect(page).to have_comment message
      end
    end
  end

  # As a User
  # So that I can rectify what I originally comment
  # I want to delete my comments
  context 'deleting comments' do
    given!(:message) { create(:comment, user: user, post: post)}

    scenario 'can delete a comment on an existing post' do
      visit root_path

      within '.comments' do
        expect(page).to have_username user
        expect(page).to have_comment message
      end

      delete_comment

      expect(page).not_to have_comment message
    end

    # As a User
    # So that I can protect comments from deleting by another user
    # I want to delete comments that only belong to me
    context "can't delete a comment not belonging to them" do
      given(:user_two) { create :user }
      given!(:message_two) { create :comment, user: user_two, post: post }

      scenario 'via the user interface' do
        visit root_path

        within '.comments' do
          expect(page).to have_comment message_two
          expect(page).not_to have_delete_icon
        end
      end

      scenario 'via the URLs' do
        visit root_path

        page.driver.submit :delete, "posts/#{post.id}/comments/#{message_two.id}", {}

        expect(page).to have_content t('comments.owned_comment.alert')
        expect(find('.comments')).to have_comment message_two
      end
    end
  end

  # As a User
  # So that I can see a profile of user who commented on my post
  # I want to link user's profile to the username in comment
  context 'viewing comments' do
    given(:user_two) { create :user }
    given!(:message) { create :comment, user: user_two, post: post }

    scenario 'can see a profile of user who commented on my post' do
      visit root_path

      first('.comment').click_link user_two.username

      expect(page).to have_current_path profile_path(user_two.username)
    end
  end
end
