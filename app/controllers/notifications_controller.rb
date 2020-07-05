class NotificationsController < ApplicationController
  before_action :user_signed_in?, only: :index
  def index
    @notifications = current_user.passive_notifications
    @notifications.each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
