require 'rails_helper'

module AuthHelpers
  def sign_up_as user
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: user.email
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password, match: :first
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button 'Sign up'
  end

  def log_in_as user
    visit root_path
    click_link 'Log in'
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def log_out
    click_link 'Log out'
  end
end
