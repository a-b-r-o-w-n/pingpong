class AddOwpOowpRpiToUsers < ActiveRecord::Migration
  def change
    add_column :users, :owp, :float, default: 0
    add_column :users, :oowp, :float, default: 0
    add_column :users, :rpi, :float, default: 0
  end
end
