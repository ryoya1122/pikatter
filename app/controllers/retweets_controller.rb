class RetweetsController < ApplicationController
  before_action :notification_check
  
	def create
		@tweet = Tweet.find(params[:tweet_id])
        retweet = current_user.retweets.new(tweet_id: @tweet.id)
        retweet.save
        if Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ", current_user.id, @tweet.user_id, @tweet.id, 'retweet']).blank?
      	notification = current_user.active_notifications.new(
      	visited_id: @tweet.user_id,
        tweet_id: @tweet.id,
        visitor_id: current_user.id,
        action: 'retweet'
      	)
      	if notification.visitor_id == notification.visited_id
        	notification.checked = true
      	end
      	notification.save
      end
  	end
  	def destroy
  		@tweet = Tweet.find(params[:tweet_id])
        retweet = current_user.retweets.find_by(tweet_id: @tweet.id)
        retweet.destroy
  	end
end