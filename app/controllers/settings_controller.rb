class SettingsController < ApplicationController
	before_action :set_user


	def index
	end
	def negablock
	end
	def negastrict
	end
	def privacy
	end

	private

	def set_user
		@user = current_user
	end
end