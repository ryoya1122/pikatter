class TweetsController < ApplicationController
	PER = 8
	def create
		@newtweet = Tweet.new(tweet_params)
		@newtweet.user_id = current_user.id

		require 'cotoha'
		client_id = ENV['COTOHA_API_KEY']
		client_secret = ENV['COTOHA_API_SECRET']
		client = Cotoha::Client.new(client_id: client_id, client_secret: client_secret)
		client.create_access_token

		@data = client.sentiment(sentence: @newtweet.body)
		@newtweet.sentiment = @data["result"]["sentiment"]
		@newtweet.score = @data["result"]["score"]

		case @newtweet.sentiment
			when 'Positive'
				@newtweet.score *= 33
				@newtweet.score += 66
			when 'Neutral'
				@newtweet.score *= 33
				@newtweet.score += 33
			when 'Negative'
				@newtweet.score *= -33
				@newtweet.score += 33
		end
		@user = current_user
		@user.tweet_count += 1
		@user.score_average = ( @user.score_average * ( @user.tweet_count - 1 ) + @newtweet.score ) / @user.tweet_count
		@user.save
		if AverageScore.find_by(user_id: current_user.id, day: Date.today).blank?
			@average_score = AverageScore.new
			@average_score.user_id = current_user.id
			@average_score.score = @newtweet.score
			@average_score.count = 1
			@average_score.day = Date.today
		else
			@average_score = AverageScore.find_by(user_id: current_user.id, day: Date.today)
			@average_score.score = ( @average_score.score * @average_score.count + @newtweet.score ) / (@average_score.count + 1 )
			@average_score.count += 1
		end
		@average_score.save
		if @newtweet.save
			@newtweet = Tweet.new
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
		else
		   #ツイートできなかった時の処理
		end
	end
	def show
		@tweet = Tweet.find(params[:id])
		@user = current_user
		@newreply = Reply.new
		@replys = Reply.where(tweet_id: @tweet.id)
	end

	def destroy
		tweet = Tweet.find(params[:id])
        tweet.destroy
        @newtweet = Tweet.new
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
		if Tweet.where(id: params[:id]).empty?
			redirect_to root_url
		end
	end
	private
	def tweet_params
      params.require(:tweet).permit(:body)
    end

end
