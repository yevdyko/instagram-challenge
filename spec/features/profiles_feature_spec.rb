require 'rails_helper'

feature 'Profiles' do
  given(:user)      { create :user }
  given(:user_two)  { create :user }
  given!(:post)     { create :post, user: user }
  given!(:post_two) { create :post, user: user_two }
  
  context 'viewing user profiles' do
    background do 
      log_in_as user
      visit root_path
      first('.username').click_link user.username
    end
    
    # As a User
    # So that I can visit a profile page
    # I want to see the username in the URL
    scenario 'visiting a profile page shows the username in the URL' do
      expect(page.current_path).to eq profile_path(user.username) 
    end
    
    # As a User
    # So that I can visit a profile page
    # I want to see only the specified user's posts
    scenario "a profile page only shows the specified user's posts" do
      expect(page).to have_content post.description
      expect(page).not_to have_content post_two.description
    end
  end
end
