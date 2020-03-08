class AddScoreAverageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :score_average, :float, default: 0
  end
end
