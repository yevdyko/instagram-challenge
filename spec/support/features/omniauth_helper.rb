module OmniAuthHelpers
  def valid_facebook_login_setup
    if Rails.env.test?
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '123545',
        info: {
          email: 'john@example.com',
          name:  'John Doe',
          image: 'https://graph.facebook.com/v2.6/123545/picture'
        },
        credentials: {
          token: 'ACCESS_TOKEN',
          expires_at: Time.current + 1.week
        }
      )
    end
  end

  def facebook_login_failure
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end
end
