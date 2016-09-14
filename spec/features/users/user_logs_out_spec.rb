require 'rails_helper'

# As a logged in User
# So that no one else can use my account
# I want to be able to log out
feature 'User logs out' do
  scenario 'can see a logged out message', js: true do
    user = create :user

    log_in_as user
    log_out

    expect(page).to have_content t('devise.sessions.signed_out')
    expect(page).to have_current_path new_user_registration_path
    expect(page).to have_link t('application.header.login'),
                              href: new_user_session_path
  end
end
