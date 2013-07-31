class AddWinPercentageToUser < ActiveRecord::Migration
  def change
  	add_column :users, :winning_percentage, :decimal, default: 0
  end
end
