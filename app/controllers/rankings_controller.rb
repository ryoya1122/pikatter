class RankingsController < ApplicationController
	before_action :notification_check
	
	def index

		@users = User.where(score_privacy_rankings: 0).order(score_average: "DESC").first(3)
		@score_average = User.average(:score_average)
	end
end
