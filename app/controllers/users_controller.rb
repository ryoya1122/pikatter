class UsersController < ApplicationController
	def show
		@user = User.find_by!(name: params[:name])
		@tweets = Tweet.where(user_id: @user.id).order(id: "DESC")
		@most_positive = Tweet.where(user_id: @user.id).order("score DESC").first
		@most_negative = Tweet.where(user_id: @user.id).order("score").first
		@favorite = Favorite.new
	end
	def edit
		@user = User.find_by!(name: params[:name])
	end
	def update
		@user = User.find_by!(name: params[:name])
    	if @user.update(user_params)
    		redirect_to user_path(@user)
    	else
    		render :edit
    	end
	end

	private
	def user_params
		params.require(:user).permit(:name, :image, :email)
	end
end