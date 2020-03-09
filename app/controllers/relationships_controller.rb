class RelationshipsController < ApplicationController
	before_action :set_user

  def create
    user = User.find(params[:follow_id])
    following = current_user.follow(user)
    if following.save
    	#あとで非同期処理
    else
    end
  end

  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
    	#あとで非同期処理
    else
    end
  end

  private

  def set_user
    user = User.find(params[:follow_id])
  end
end
