require 'rails_helper'

module AuthHelpers
  def sign_up_as(user)
    visit root_path
    
    click_link t('application.header.signup')
    fill_in t('registration.email'), with: user.email
    fill_in t('registration.username'), with: user.username
    fill_in t('registration.password'), with: user.password, match: :first
    fill_in t('registration.password_confirmation'), with: user.password_confirmation
    click_button t('registration.signup')
  end

  def log_in_as(user)
    visit root_path
    
    click_link t('application.header.login')
    fill_in t('registration.email'), with: user.email
    fill_in t('registration.password'), with: user.password
    click_button t('registration.login')
  end

  def log_out
    click_link t('application.header.logout')
  end
end
