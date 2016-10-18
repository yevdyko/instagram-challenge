module AuthenticationHelpers
  def sign_up_as(user)
    visit root_path

    fill_in t('registration.email'),    with: user.email
    fill_in t('registration.username'), with: user.username
    fill_in t('registration.password'), with: user.password, match: :first
    fill_in t('registration.password_confirmation'), with: user.password_confirmation
    click_button t('registration.signup')
  end

  def log_in_as(user)
    visit root_path

    click_on t('application.header.login')
    fill_in t('registration.email'),    with: user.email
    fill_in t('registration.password'), with: user.password
    click_button t('registration.login')
  end

  # Requires Javascript driver
  def log_out
    select_click_action

    find('.btn-options--profile').click
    click_link t('application.modal.logout')
  end

  # Log out without JavaScript driver
  def log_out_direct
    page.driver.submit :delete, '/users/logout', {}
  end

  private

  def select_click_action
    if Capybara.javascript_driver == :selenium
      find('.user-block-link#profile').click
    else
      find('.user-block-link#profile').trigger('click')
    end
  end
end
