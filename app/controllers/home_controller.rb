class HomeController < ApplicationController
	before_action :authenticate_user!
	PER = 8

	def index
		@user = current_user
		@newtweet = Tweet.new
		@tweets = Tweet.all.order(id: "DESC").page(params[:page]).per(PER)
		@favorite = Favorite.new
	end

end
