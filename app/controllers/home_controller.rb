class HomeController < ApplicationController
	before_action :authenticate_user!
	before_action :notification_check
	PER = 8

	def index
		group_by_id = tweets_get
		tweets_array = group_by_id.values.map{|a| a[0] }.sort_by! { |a| a[:updated_at] }.reverse!
		@tweets = Kaminari.paginate_array(tweets_array).page(params[:page]).per(10)
		@favorite = Favorite.new
		@newreply = Reply.new
		@newtweet = Tweet.new
		@user = current_user
	end

	def settings
		@user = current_user
	end
end