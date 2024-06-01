class NotificationsController < ApplicationController
  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      NotificationBroadcastJob.perform_later(@notification)
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:message, :user_id)
  end
end