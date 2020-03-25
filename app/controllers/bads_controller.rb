class BadsController < ApplicationController
	before_action :notification_check
	
	def create
		@tweet = Tweet.find(params[:tweet_id])
        bad = current_user.bads.new(tweet_id: @tweet.id)
        bad.save
	end
	def destroy
		@tweet = Tweet.find(params[:tweet_id])
        bad = current_user.bads.find_by(tweet_id: @tweet.id)
        bad.destroy
  	end
end
