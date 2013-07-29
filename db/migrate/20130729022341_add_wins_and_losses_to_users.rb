class AddWinsAndLossesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :wins, 	:integer, default: 0
  	add_column :users, :losses, :integer, default: 0
  end
end
