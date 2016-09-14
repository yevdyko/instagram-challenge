module Users
  class SessionsController < Devise::SessionsController
    skip_before_action :show_navbar, only: :new
  end
end
