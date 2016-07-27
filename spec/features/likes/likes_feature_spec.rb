require 'rails_helper'

feature 'Liking posts' do
  given(:user) { create :user }
  given!(:post) { create :post, user: user }

  background do
    log_in_as user
  end

  scenario 'can like a post' do
    visit root_path
    expect(page).to have_css 'a.glyphicon-heart-empty'
  end
end
