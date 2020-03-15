class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
 	  t.integer :visitor_id, null: false
 	  t.integer :visited_id, null: false
 	  t.integer :tweet_id
 	  t.integer :retweet_id
 	  t.integer :favorite_id
 	  t.string :action, default: '', null: false
 	  t.boolean :checked, default: false, null: false
      t.timestamps
    end

    
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :tweet_id
    add_index :notifications, :retweet_id
    add_index :notifications, :favorite_id

  end
end
