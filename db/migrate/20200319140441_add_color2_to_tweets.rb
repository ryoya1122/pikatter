class AddColor2ToTweets < ActiveRecord::Migration[5.2]
  def change
    change_column :tweets, :color, :string, :default => "white"
  end
end
