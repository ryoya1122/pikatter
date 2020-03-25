class FollowingsController < ApplicationController
	before_action :notification_check
	
	def show
		@user = User.find_by!(name: params[:user_name])
	end
end
