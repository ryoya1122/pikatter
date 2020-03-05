class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
		@user = current_user
		@tweet = Tweet.new
		@tweets = Tweet.all.order(id: "DESC")
	end

end
