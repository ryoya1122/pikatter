class Favorite < ApplicationRecord
	belongs_to :user
    belongs_to :tweet
    validates_uniqueness_of :tweet_id, scope: :user_id
    has_many :notifications, dependent: :destroy
end
