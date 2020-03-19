class AddColorToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :color, :string
  end
end
