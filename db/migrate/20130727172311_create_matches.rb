class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
    	t.string :status
    	t.integer :player1_id, require: true
    	t.integer :score1, default: 0
    	t.integer :player2_id, require: true
    	t.integer :score2, default: 0

      t.timestamps
    end
  end
end
