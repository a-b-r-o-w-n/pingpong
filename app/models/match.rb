class Match < ActiveRecord::Base
	# score1 is player1's score and score2 is player2's score
  before_create :set_to_pending


  STATUS_CHOICES = {
   'Complete' => 'C',
   'Pending'  => 'P',
   'Canceled' => 'X'
  }

  attr_accessible :status, :player1, :score1, :player2, :score2

  belongs_to :player1, class_name: "User", foreign_key: :player1_id
  belongs_to :player2, class_name: "User", foreign_key: :player2_id

  validates :player1, presence: true
  validates :player2, presence: true
  validate :cannot_play_self

  validates_inclusion_of :status, in: STATUS_CHOICES.values, allow_nil: true


  def winner
  	if self.status == 'C'
	    self.score1 > self.score2 ? self.player1 : self.player2
  	end
  end


  private
  def cannot_play_self
    errors[:base] << 'You cannot add yourself as a friend.' if self.player1_id == self.player2_id
  end

  def set_to_pending
    self.status = 'P'
  end

end
