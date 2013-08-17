class Match < ActiveRecord::Base
	# score1 is player1's score and score2 is player2's score
  after_save :update_users_stats


  STATUS_CHOICES = {
   'Pending'      =>  'P',
   'In Progress'  => 'IP',
   'Complete'     =>  'C',
   'Canceled'     =>  'X'
  }

  attr_accessible :status, :score1, :score2, :player1_id, :player2_id, :tournament_id

  belongs_to :player1, class_name: "User", foreign_key: :player1_id
  belongs_to :player2, class_name: "User", foreign_key: :player2_id
  belongs_to :tournament

  validates :player1, presence: true
  validates :player2, presence: true
  validate :cannot_play_self

  validates_inclusion_of :status, in: STATUS_CHOICES.values, allow_nil: true


  def winner
  	if self.status == 'C'
	    self.score1 > self.score2 ? self.player1 : self.player2
  	end
  end

  def players
    [self.player1, self.player2]
  end

  def to_s
    "#{self.player1} vs. #{self.player2}"
  end

  def long_status
    STATUS_CHOICES.invert[self.status]
  end


  private
  def cannot_play_self
    errors[:base] << 'You cannot add yourself as a friend.' if self.player1_id == self.player2_id
  end

  def update_users_stats
    User.update_stats
  end

end
