module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.find_or_create_by_auth(auth_hash)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      else
        session['devise.facebook_data'] = auth_hash
        redirect_to new_user_registration_url, notice: 'Please provide a password to finish setting up your account.'
      end
    end

    def failure
      flash[:alert] = 'Authentication failed.'
      redirect_to root_path
    end

    protected

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
