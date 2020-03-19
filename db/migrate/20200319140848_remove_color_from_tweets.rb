class RemoveColorFromTweets < ActiveRecord::Migration[5.2]
  def change
    remove_column :tweets, :color, :string
  end
end
