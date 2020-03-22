class Tweet < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :retweets, dependent: :destroy
	has_many :bads, dependent: :destroy
	has_many :notifications, dependent: :destroy
	has_many :replys, dependent: :destroy
	def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
 	end
 	def retweeted_by?(user)
 		  retweets.where(user_id: user.id).exists?
 	end
 	def baded_by?(user)
 		  bads.where(user_id: user.id).exists?
 	end
end