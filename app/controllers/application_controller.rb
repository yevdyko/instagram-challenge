class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :show_navbar

  protected

  def show_navbar
    @show_navbar = true
  end
end
