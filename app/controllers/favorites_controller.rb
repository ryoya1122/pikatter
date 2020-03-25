class FavoritesController < ApplicationController
  before_action :notification_check
  
	def create
		@tweet = Tweet.find(params[:tweet_id])
        favorite = current_user.favorites.new(tweet_id: @tweet.id)
        favorite.save
        if Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ", current_user.id, @tweet.user_id, @tweet.id, 'favorite']).blank?
      	notification = current_user.active_notifications.new(
      	visited_id: @tweet.user_id,
        tweet_id: @tweet.id,
        visitor_id: current_user.id,
        action: 'favorite'
      	)
      	if notification.visitor_id == notification.visited_id
        	notification.checked = true
      	end
      	notification.save
      end
	end
	def destroy
		@tweet = Tweet.find(params[:tweet_id])
        favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
        favorite.destroy
  	end
end
