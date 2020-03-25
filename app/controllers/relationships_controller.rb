class RelationshipsController < ApplicationController
  before_action :notification_check
	before_action :set_user

  def create
    user = User.find(params[:follow_id])
    @user = User.find(params[:follow_id])
    following = current_user.follow(user)
    following.save
    if Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, user.id, 'follow']).blank?
        notification = current_user.active_notifications.new(
        visited_id: user.id,
        visitor_id: current_user.id,
        action: 'follow'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save
      end
  end

  def destroy
    user = User.find(params[:follow_id])
    @user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    following.destroy
  end

  private

  def set_user
    user = User.find(params[:follow_id])
  end
end