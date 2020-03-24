class UsersController < ApplicationController
	def show
		@user = User.find_by!(name: params[:name])
		@tweets = Tweet.where(user_id: @user.id).order(id: "DESC")
		@most_positive = Tweet.where(user_id: @user.id).order("score DESC").first
		@most_negative = Tweet.where(user_id: @user.id).order("score").first
		@favorite = Favorite.new
		@score_between = AverageScore.where(day: (7.days.ago)..(Date.today))
		@graph = {}
		@score_between.each do |score_between|
			@graph[score_between.day] = score_between.score
		end
	end
	def edit
		@user = User.find_by!(name: params[:name])
	end
	def update
		@user = User.find_by!(name: params[:name])
    	if @user.update(user_params)
    		redirect_to settings_url
    	else
    		render :edit
    	end
	end

	private
	def user_params
		params.require(:user).permit(:name, :image, :email, :color, :nickname, :negablock, :negablock_value, :negarest, :negarest_value, :score_privacy_userpage, :score_privacy_rankings)
	end
end