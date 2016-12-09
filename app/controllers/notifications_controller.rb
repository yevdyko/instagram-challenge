class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
                                 .order(created_at: :desc)
                                 .page(params[:page])
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to post_path @notification.post
  end

  def mark_all_as_read
    @notification = Notification.find_by(id: params[:id], user: current_user)
    @notification.update_all read: true
  end
end
