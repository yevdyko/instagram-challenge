class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :show_navbar

  protected

  def show_navbar
    @show_navbar = true
  end

  def skip_footer
    @skip_footer = true
  end
end
