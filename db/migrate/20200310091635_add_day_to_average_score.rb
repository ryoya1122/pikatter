class AddDayToAverageScore < ActiveRecord::Migration[5.2]
  def change
    add_column :average_scores, :day, :date
  end
end
