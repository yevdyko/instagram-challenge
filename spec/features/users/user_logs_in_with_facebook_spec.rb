require 'rails_helper'

# As a User
# So that I can log in easily
# I want to connect my account to Facebook

# As an existing User
# So that I can post pictures on Pixagram as me
# I want to be able to log in
feature 'User logs in with facebook' do
  scenario 'successfully' do
    valid_facebook_login_setup

    visit root_path
    click_on t('registration.login_with_facebook')

    expect(page).to have_current_path authenticated_root_path
    expect(page).to have_content t('devise.omniauth_callbacks.success', kind: 'Facebook')
  end

  scenario 'can handle authentication error' do
    facebook_login_failure

    visit root_path
    click_on t('registration.login_with_facebook')

    expect(page).to have_content 'Authentication failed.'
  end
end
