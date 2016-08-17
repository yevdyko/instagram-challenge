class ProfilesController < ApplicationController
  before_action :set_user
  before_action :owned_profile, only: %i(edit update)

  def show
    @posts = User.find_by(username: params[:username]).posts.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      redirect_to profile_path(@user.username), notice: t('profiles.update.notice')
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end

  def owned_profile
    @user = User.find_by(username: params[:username])

    unless current_user == @user
      redirect_to root_path, alert: t('profiles.owned_profile.alert')
    end
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
