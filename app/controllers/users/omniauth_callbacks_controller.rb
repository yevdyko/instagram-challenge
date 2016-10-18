module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      load_or_create_user

      log_in_or_create_new_user
    end

    def failure
      flash[:alert] = t('omniauth.failure')
      redirect_to root_path
    end

    protected

    def auth_hash
      request.env['omniauth.auth']
    end

    def load_or_create_user
      @user = User.find_or_create_by(auth_hash)
    end

    def log_in_or_create_new_user
      if @user.persisted?
        log_in_with_auth
      else
        create_new_user_with_auth
      end
    end

    def log_in_with_auth
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end

    def create_new_user_with_auth
      session['devise.facebook_data'] = auth_hash
      redirect_to new_user_registration_url, notice: t('omniauth.persisted')
    end
  end
end
