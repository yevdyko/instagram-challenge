require 'rails_helper'

feature 'Deleting comments' do
  given(:john) { create :user }
  given!(:johns_post)    { create(:post, user: john) }
  given!(:johns_comment) { create(:comment, user: john, post: johns_post) }

  # As a User
  # So that I can rectify what I originally comment
  # I want to delete my comments
  scenario 'can delete a comment on an existing post' do
    log_in_as john

    within '.comments' do
      expect(page).to have_username john
      expect(page).to have_comment johns_comment
    end

    delete_comment(johns_comment)

    expect(page).not_to have_comment johns_comment
  end

  # As a User
  # So that I can protect comments from deleting by another user
  # I want to delete comments that only belong to me
  context "can't delete a comment not belonging to them" do
    given(:mike) { create :user }
    given!(:mikes_comment) { create(:comment, user: mike, post: johns_post) }

    scenario 'via the user interface' do
      log_in_as john

      within '.comments' do
        expect(page).to have_comment mikes_comment
        expect(page).not_to have_delete_icon
      end
    end

    scenario 'via the URLs' do
      path = "posts/#{johns_post.id}/comments/#{mikes_comment.id}"

      log_in_as john
      page.driver.submit :delete, path, {}

      expect(page).to have_content t('comments.owned_comment.alert')
      expect(find('.comments')).to have_comment mikes_comment
    end
  end
end
