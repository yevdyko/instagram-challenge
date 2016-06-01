require 'rails_helper'

module AuthHelpers
  def log_in_with user
    visit '/'
    click_link 'Log in'
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def log_out
    click_link 'Log out'
  end
end