module Users
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :show_navbar, only: %i(new create)

    private

    def sign_up_params
      params.require(:user).permit(:email, :username,
                                   :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:email, :username, :password,
                                   :password_confirmation, :current_password)
    end
  end
end
