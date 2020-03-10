class CreateAverageScores < ActiveRecord::Migration[5.2]
  def change
    create_table :average_scores do |t|
      t.integer :user_id
      t.day :day
      t.float :score, default: 0
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
