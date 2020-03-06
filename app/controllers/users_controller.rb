class UsersController < ApplicationController
	def show
		@user = User.find_by!(name: params[:name])
		@tweets = Tweet.where(user_id: @user.id).order(id: "DESC")
	end
end