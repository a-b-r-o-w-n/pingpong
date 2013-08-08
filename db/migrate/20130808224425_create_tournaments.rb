class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :tournament_type
      t.integer :num_players

      t.timestamps
    end
  end
end
