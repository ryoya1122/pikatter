class AddTweetCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tweet_count, :integer, default: 0
  end
end
