class TweetsController < ApplicationController
	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user_id = current_user.id
		if @tweet.save
			redirect_to root_path
		else
		   #ツイートできなかった時の処理
		end
	end

	private
	def tweet_params
      params.require(:tweet).permit(:body)
    end
end
