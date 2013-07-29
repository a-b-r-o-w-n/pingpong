class Match < ActiveRecord::Base
	# score1 is player1's score and score2 is player2's score


  attr_accessible :status, :player1_id, :score1, :player2_id, :score2

  belongs_to :player1, class_name: "User", foreign_key: :player1_id
  belongs_to :player2, class_name: "User", foreign_key: :player2_id

  def winner
  	unless self.status == 'PENDING'
	    self.score1 > self.score2 ? self.player1 : self.player2
  	else
  		"The game is not complete yet."
  	end
  end

  # TODO Add status types for matches


end
