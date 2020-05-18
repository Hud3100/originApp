class NotificationsController < ApplicationController
  def index
    # ユーザーだけでなく、companyからも呼び出したい
    @notifications = current_user.passive_notifications
    @notifications.each do |notification|
      notification.update_attributes(checked: true)
    end
    # @notifications.where(checked: false).each do |notification|
    #   notification.update_attributes(checked: true)
    # end
  end
end
