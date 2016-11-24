class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(counter, notification)
    ActionCable.server.broadcast "notifications:#{notification.user_id}", counter: render_counter(counter)
  end

  private

  def render_counter(counter)
    ApplicationController.renderer.render partial: 'notifications/counter', locals: { counter: counter }
  end
end
