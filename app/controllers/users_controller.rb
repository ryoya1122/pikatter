class UsersController < ApplicationController
	before_action :notification_check
	before_action :set_user
	def show
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
		check_user = current_user
		unless @user == check_user
			redirect_to edit_user_url(User.find_by!(name: current_user.name))
		end
	end
	def update
    	if @user.update(user_params)
    		redirect_to settings_url
    	else
    		render :edit
    	end
	end
	def destroy
		user = current_user
		user.passive_notifications.destroy_all
		user.active_notifications.destroy_all
		user.destroy
		redirect_to root_url
	end
	private

	def set_user
		@user = User.find_by!(name: params[:name])
	end
	def user_params
		params.require(:user).permit(:name, :image, :email, :nickname, :negablock, :negablock_value, :negarest, :negarest_value, :score_privacy_userpage, :score_privacy_rankings)
	end
end