class TweetsController < ApplicationController
	def create
		@newtweet = Tweet.new(tweet_params)
		@newtweet.user_id = current_user.id
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
