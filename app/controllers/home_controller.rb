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
		@tweet_array = []
		@tweet_hash = Hash.new{[]}
		@retweet_ids.each do |retweet_id|
			@tweet_hash = Hash.new{[]}
			@tweet_hash["id"]=retweet_id.tweet.id
			@tweet_hash["body"]=retweet_id.tweet.body
			@tweet_hash["user_id"]=retweet_id.tweet.user_id
			@tweet_hash["status"]= 1
			@tweet_hash["status_by"]= retweet_id.user_id
			@tweet_hash["score"]= retweet_id.tweet.score
			@tweet_hash["created_at"]= retweet_id.tweet.created_at
			@tweet_hash["updated_at"]= retweet_id.tweet.updated_at
			@tweet_array.push(@tweet_hash)
		end
		@newtweet = Tweet.new
		@follow_tweets = Tweet.where(user_id: @following_user_id)

		@follow_tweets.each do |follow_tweet|
			@tweet_hash = Hash.new{[]}
			@tweet_hash["id"]=follow_tweet.id
			@tweet_hash["body"]=follow_tweet.body
			@tweet_hash["user_id"]=follow_tweet.user_id
			@tweet_hash["status"]= 0
			@tweet_hash["score"]= follow_tweet.score
			@tweet_hash["created_at"]= follow_tweet.created_at
			@tweet_hash["updated_at"]= follow_tweet.updated_at
			@tweet_array.push(@tweet_hash)
		end
		@tweets = @tweet_array.sort_by! {|h| h["updated_at"]}.reverse
		@favorite = Favorite.new
		@newreply = Reply.new
	end
end