require 'rails_helper'

# As a logged-in User
# So that no one else can use my account
# I want to log out
feature 'User logs out' do
  scenario 'to end his session on the website' do
    user = create :user

    log_in_as user
    log_out

    expect(page).to have_current_path new_user_registration_path
  end
end
