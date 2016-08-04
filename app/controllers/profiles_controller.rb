class ProfilesController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
    @posts = User.find_by(username: params[:username]).posts.order(created_at: :desc)
  end

  def edit
    @user = User.find_by(username: params[:username])
  end
end
