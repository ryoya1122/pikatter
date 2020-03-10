class RemoveDayFromAverageScore < ActiveRecord::Migration[5.2]
  def change
    remove_column :average_scores, :day, :time
  end
end
