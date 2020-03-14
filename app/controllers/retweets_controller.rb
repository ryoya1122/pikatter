class RetweetsController < ApplicationController
	def create
		@tweet = Tweet.find(params[:tweet_id])
        retweet = current_user.retweets.new(tweet_id: @tweet.id)
        retweet.save
  	end
  	def destroy
  		@tweet = Tweet.find(params[:tweet_id])
        retweet = current_user.retweets.find_by(tweet_id: @tweet.id)
        retweet.destroy
  	end
end