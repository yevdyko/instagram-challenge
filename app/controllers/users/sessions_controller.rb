module Users
  class SessionsController < Devise::SessionsController
    skip_before_action :show_navbar, only: :new
    before_action :skip_footer
  end
end
