class TweetsController < ApplicationController
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

		if @newtweet.save
			@newtweet = Tweet.new
			@tweets = Tweet.all.order(id: "DESC")
		else
		   #ツイートできなかった時の処理
		end
	end

	private
	def tweet_params
      params.require(:tweet).permit(:body)
    end

end
