class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :user_id
      t.text :body
      t.float :emotion
      t.string :tweet_image_id

      t.timestamps
    end
  end
end
