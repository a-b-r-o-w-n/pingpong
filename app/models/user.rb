class User < ActiveRecord::Base

  after_create :set_new_stats

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :matches1, class_name: "Match", foreign_key: :player1_id
  has_many :matches2, class_name: "Match", foreign_key: :player2_id
  has_many :tournament_users



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

  def self.update_stats
    @users = User.all
    @users.each { |u| u.update_wins           }
    @users.each { |u| u.update_losses         }
    @users.each { |u| u.update_owp            }
    @users.each { |u| u.update_oowp           }
    @users.each { |u| u.update_rpi            }
    @users.each { |u| u.update_rank(@users)   }
  end

  def update_wins
    old_stat = self.wins
    self.update_attribute :wins, self.matches_won.count
    logger.tagged("STATS", "WINS") { logger.info "#{self.full_name} wins updated from [#{old_stat}] to [#{self.wins}]." if old_stat != self.wins }
  end

  def update_losses
    old_stat = self.losses
    self.update_attribute :losses, self.matches_lost.count
    logger.tagged("STATS", "LOSSES") { logger.info "#{self.full_name} losses updated from [#{old_stat}] to [#{self.losses}]." if old_stat != self.losses }
  end

  def update_owp
    old_stat = self.owp
    self.update_attribute :owp, self.total_matches_played > 0 ? average_array(self.opponents.map(&:winning_percentage)) : 0
    logger.tagged("STATS", "OWP") { logger.info "#{self.full_name} owp updated from [#{old_stat}] to [#{self.owp}]." if (old_stat - self.owp) > 0.2 }
  end

  def update_oowp
    old_stat = self.oowp
    self.update_attribute :oowp, self.total_matches_played > 0 ? average_array(self.opponents.map(&:owp)) : 0
    logger.tagged("STATS", "OOWP") { logger.info "#{self.full_name} oowp updated from [#{old_stat}] to [#{self.oowp}]." if (old_stat - self.oowp) > 0.2 }
  end

  def update_rpi
    old_stat = self.rpi
    self.update_attribute :rpi, (self.winning_percentage * 0.40) + (self.owp * 0.35) + (self.oowp * 0.25)
    logger.tagged("STATS", "RPI") { logger.info "#{self.full_name} oowp updated from [#{old_stat}] to [#{self.rpi}]." if (old_stat - self.rpi) > 0.2 }
  end

  def update_rank(users)
    old_stat = self.rank
    self.update_attribute :rank, users.count(conditions: "rpi > #{self.rpi}") + 1
    logger.tagged("STATS", "RANK") { logger.info "#{self.full_name} oowp updated from [#{old_stat}] to [#{self.rank}]." if old_stat != self.rank }
  end

  private
  def average_array(ary)
    ary.inject(:+).to_f / ary.size
  end

  def set_new_stats
    User.update_stats
  end

end
