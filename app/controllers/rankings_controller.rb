class RankingsController < ApplicationController
	def index

		@users = User.all.order(score_average: "DESC").first(3)
		@score_average = User.average(:score_average)
	end
end
