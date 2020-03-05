class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
		@user = current_user
		@newtweet = Tweet.new
		@tweets = Tweet.all.order(id: "DESC")
	end

end
