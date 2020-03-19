class HomeController < ApplicationController
	before_action :authenticate_user!
	PER = 8

	def index
		@user = current_user
		@users = @user.followings
		@following_user_id = []
		@users.each do |following|
			@following_user_id.push(following.id)
		end
		@following_user_id.push(current_user.id)
		@retweet_ids = Retweet.where(user_id: @following_user_id)
		@retweet_tweets = []
		@retweet_ids.each do |retweet_id|
			tweet = Tweet.where(id: retweet_id.tweet_id)
			tweet.update_all(status: retweet_id.user.name+ "さんがリツイートしました")
			tweet.update_all(status_by_user: retweet_id.user_id)
			@retweet_tweets += tweet
		end
		@newtweet = Tweet.new
		@follow_tweets = Tweet.where(user_id: @following_user_id)
		@tweets = (@retweet_tweets + @follow_tweets).uniq
		@tweets = Tweet.where(id: @tweets.uniq.map{ |tweet| tweet.id }).order(:updated_at).page(params[:page]).per(PER)
		@favorite = Favorite.new
	end
end