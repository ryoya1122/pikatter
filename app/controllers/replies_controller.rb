class RepliesController < ApplicationController
	def create
		@newreply = Reply.new(reply_params)
		@newreply.user_id = current_user.id
		@newreply.save
		@replys = Reply.where(tweet_id: params[:tweet_id])
		@tweet = Tweet.find(params[:tweet_id])
		@newreply = Reply.new
	end
	def new
	end

	private
	def reply_params
      params.require(:reply).permit(:body, :tweet_id)
    end
end
