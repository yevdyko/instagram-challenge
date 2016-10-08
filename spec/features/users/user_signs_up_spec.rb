require 'rails_helper'

# As a User
# So that I can post pictures on Pixagram as me
# I want to register for my account
feature 'User signs up' do
  context 'with no errors' do
    scenario 'using valid credentials' do
      user = build :user

      sign_up_as user

      expect(page).to have_content t('devise.registrations.signed_up')
      expect(page).to have_current_path authenticated_root_path
    end
  end

  context 'with errors' do
    scenario 'invalid email' do
      user = build(:user, email: 'johnemailcom')

      sign_up_as user

      expect(page).to have_content t('simple_form.error_notification.default_message')
      expect(page).to have_content t('errors.messages.invalid')
    end

    scenario 'already registered email' do
      user = create :user

      sign_up_as user

      expect(page).to have_content t('simple_form.error_notification.default_message')
      expect(page).to have_content t('errors.messages.taken')
    end

    scenario 'missing email' do
      user = build(:user, email: nil)

      sign_up_as user

      expect(page).to have_content t('simple_form.error_notification.default_message')
      expect(page).to have_content t('errors.messages.blank')
    end

    scenario 'missing username' do
      user = build(:user, username: nil)

      sign_up_as user

      expect(page).to have_content t('simple_form.error_notification.default_message')
      expect(page).to have_content t('errors.messages.blank')
    end

    scenario 'missing password' do
      user = build(:user, password: nil)

      sign_up_as user

      expect(page).to have_content t('simple_form.error_notification.default_message')
      expect(page).to have_content t('errors.messages.blank')
      expect(page).to have_content t('errors.messages.confirmation',
                                     attribute: 'Password')
    end

    scenario 'missing password confirmation' do
      user = build(:user, password_confirmation: nil)

      sign_up_as user

      expect(page).to have_content t('simple_form.error_notification.default_message')
      expect(page).to have_content t('errors.messages.confirmation',
                                     attribute: 'Password')
    end

    context 'username with' do
      scenario 'less than 3 characters' do
        user = build(:user, username: 'w')

        sign_up_as user

        expect(page).to have_content t('simple_form.error_notification.default_message')
        expect(page).to have_content t('errors.messages.too_short.other', count: 3)
      end

      scenario 'more than 12 characters' do
        user = build(:user, username: 'johndoeknucklesjames')

        sign_up_as user

        expect(page).to have_content t('simple_form.error_notification.default_message')
        expect(page).to have_content t('errors.messages.too_long.other', count: 12)
      end
    end

    scenario 'incorrect password confirmation' do
      user = build(:user, password_confirmation: 's3cret')

      sign_up_as user

      expect(page).to have_content t('simple_form.error_notification.default_message')
      expect(page).to have_content t('errors.messages.confirmation',
                                     attribute: 'Password')
    end
  end
end
