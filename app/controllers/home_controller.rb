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
		@newtweet = Tweet.new
		@tweets = Tweet.where(user_id: @following_user_id).order(created_at: "DESC").page(params[:page]).per(PER)
		@favorite = Favorite.new
		binding.pry
	end
end