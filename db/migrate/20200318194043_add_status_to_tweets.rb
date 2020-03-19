class AddStatusToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :status, :string
    add_column :tweets, :status_by_user, :integer
  end
end
