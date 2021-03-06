class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_tweets, through: :favorites, source: :tweet, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy
  has_many :average_scores, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :bads, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :replys, dependent: :destroy
  attachment :image
  validates :name, format: {with: /\A[a-z0-9]+\z/ }, length: { in: 4..12 }
  validates :nickname, length: { in: 1..11 }
  def to_param
    name
  end
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  def following?(other_user)
    self.followings.include?(other_user)
  end
end