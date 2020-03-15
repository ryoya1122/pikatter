class NotificationsController < ApplicationController
	PER = 20

	def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(PER)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
