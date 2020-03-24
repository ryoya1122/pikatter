class AddSettingsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string
    add_column :users, :negablock, :boolean, :default => false
    add_column :users, :negablock_value, :integer, :default => 100
    add_column :users, :negarest, :boolean, :default => false
    add_column :users, :negarest_value, :integer, :default => 0
    add_column :users, :score_privacy_userpage, :boolean, :default => false
    add_column :users, :score_privacy_rankings, :boolean, :default => false
  end
end
