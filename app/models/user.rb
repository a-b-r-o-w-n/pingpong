  class User < ActiveRecord::Base

  after_create :update_stats

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :profile_name, :wins, :losses,
                  :player1_id, :player2_id, :rank_score, :rank, :opponents

  has_many :matches1, class_name: "Match", foreign_key: :player1_id
  has_many :matches2, class_name: "Match", foreign_key: :player2_id

  
  
  validate :first_name,     presence: true,
                              length: { minimum: 1, maximum: 30 }

  validate :last_name,      presence: true,
                              length: { minimum: 1, maximum: 30 }

  validate :profile_name,   presence: true,
                          uniqueness: true,
                              length: { minimum: 3, maximum: 25 },
                              format: { with: /\A[a-zA-Z0-9_-]+\Z/, message: "can only contain letters, numbers, '-' or '_'"}



  def matches
    matches1 + matches2
  end

  def complete_matches
    self.matches.select { |m| m.status == 'C' }
  end

  def matches_won
    complete_matches.select { |m| m.winner == self }
  end

  # def rank
  #   User.all.sort_by(&:winning_percentage).reverse.index(self) + 1
  # end

  def matches_lost
    complete_matches.select { |m| m.winner != self }
  end

  def record
    "#{self.wins}/#{self.losses}"
  end

  def winning_percentage
    self.total_matches_played > 0 ? self.wins.to_f / self.total_matches_played : 0
  end

  def total_matches_played
    self.wins + self.losses
  end

  def opponents
    self.matches.map(&:players).flatten.delete_if { |p| p == self }
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def to_s
    "#{self.first_name} #{self.last_name.first.upcase}."
  end

  def to_param
    self.profile_name
  end

  def update_stats
    update_wins
    update_losses
    update_owp
    update_oowp
    update_rpi
    update_rank
  end

  private
  def average_array(ary)
    ary.inject(:+).to_f / ary.size
  end

  def update_wins
    old = self.wins
    self.update_attribute :wins, matches_won.count
    puts " >>>>> #{self.full_name} wins updated from [#{old}] to [#{self.wins}]." if old != self.wins
  end

  def update_losses
    old = self.losses
    self.update_attribute :losses, matches_lost.count
    puts " >>>>> #{self.full_name} losses updated from [#{old}] to [#{self.losses}}." if old != self.losses
  end

  def update_owp
    old = self.owp
    self.update_attribute :owp, self.total_matches_played > 0 ? average_array(self.opponents.map(&:winning_percentage)) : 0
    puts " >>>>> #{self.full_name} owp updated from [#{old}] to [#{self.owp}]." if old != self.owp
  end

  def update_oowp
    old = self.oowp
    self.update_attribute :oowp, self.total_matches_played > 0 ? average_array(self.opponents.map(&:owp)) : 0
    puts " >>>>> #{self.full_name} oowp updated from [#{old}] to [#{self.oowp}]." if old != self.oowp
  end

  def update_rpi
    old = self.rpi
    self.update_attribute :rpi, (self.winning_percentage * 0.50) + (self.owp * 0.25) + (self.oowp * 0.25)
    puts " >>>>> #{self.full_name} rpi updated from [#{old}] to [#{self.rpi}]." if old != self.rpi
  end

  def update_rank
    old = self.rank
    self.update_attribute :rank, User.count(conditions: "rpi > #{self.rpi}") + 1
    puts " >>>>> #{self.full_name} rank updated from [#{old}] to [#{self.rank}]." if old != self.rank
  end

end
