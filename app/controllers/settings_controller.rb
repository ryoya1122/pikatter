class SettingsController < ApplicationController
	before_action :set_user
	before_action :notification_check


	def index
	end
	def negablock
	end
	def negastrict
	end
	def privacy
	end
	def withdraw
	end
	
	private

	def set_user
		@user = current_user
	end
end