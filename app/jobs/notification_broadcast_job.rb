class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    NotificationsChannel.broadcast_to(notification.user, message: render_notification(notification))
  end

  private

  def render_notification(notification)
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
  end
end