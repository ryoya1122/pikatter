class ApplicationController < ActionController::Base
	helper_method :tweets_get

	def tweets_get
		user = current_user
		users = user.followings
		following_user_id = user.followings.map(&:id).push(current_user.id)
		retweet_ids = Retweet.where(user_id: following_user_id)
		tweet_array = []
		tweet_hash = Hash.new{[]}
		retweet_ids.each do |retweet_id|
			tweet_hash = Hash.new{[]}
			tweet_hash[:id]=retweet_id.tweet.id
			tweet_hash[:body]=retweet_id.tweet.body
			tweet_hash[:user_id]=retweet_id.tweet.user_id
			tweet_hash[:status]= 1
			tweet_hash[:status_by]= retweet_id.user_id
			tweet_hash[:score]= retweet_id.tweet.score
			tweet_hash[:created_at]= retweet_id.tweet.created_at
			tweet_hash[:updated_at]= retweet_id.updated_at
			tweet_array.push(tweet_hash)
		end
		
		follow_tweets = Tweet.where(user_id: following_user_id)

		follow_tweets.each do |follow_tweet|
			tweet_hash = Hash.new{[]}
			tweet_hash[:id]=follow_tweet.id
			tweet_hash[:body]=follow_tweet.body
			tweet_hash[:user_id]=follow_tweet.user_id
			tweet_hash[:status]= 0
			tweet_hash[:score]= follow_tweet.score
			tweet_hash[:created_at]= follow_tweet.created_at
			tweet_hash[:updated_at]= follow_tweet.updated_at
			tweet_array.push(tweet_hash)
		end
		group_by_id = tweet_array.group_by{|a| a[:id] }
		return group_by_id
	end
end
