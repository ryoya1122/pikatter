class RepliesController < ApplicationController
	before_action :notification_check
	
	def create
		@newreply = Reply.new(reply_params)
		@newreply.user_id = current_user.id
		@newreply.save
		@replys = Reply.where(tweet_id: params[:tweet_id])
		@tweet = Tweet.find(params[:tweet_id])
		@newreply = Reply.new
	end
	
	def destroy
		@reply = Reply.find(params[:format])
		@reply.destroy
		redirect_to root_url
	end

	private
	def reply_params
      params.require(:reply).permit(:body, :tweet_id)
    end
end
