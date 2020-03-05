class AddEmotionsToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :sentiment, :string
    add_column :tweets, :score, :float
  end
end
