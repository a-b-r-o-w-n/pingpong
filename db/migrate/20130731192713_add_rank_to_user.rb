class AddRankToUser < ActiveRecord::Migration
  def change
    add_column :users, :rank, :integer
  end
end
