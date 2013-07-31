class AddRankScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rank_score, :integer, default: 0
  end
end
