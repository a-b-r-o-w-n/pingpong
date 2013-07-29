class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  				  :first_name, :last_name, :profile_name, :wins, :losses

  has_many :matches1, class_name: "Match", foreign_key: :player1_id
  has_many :matches2, class_name: "Match", foreign_key: :player2_id

  def matches
    matches1 + matches2
  end

  def record
    "#{self.wins}/#{self.losses}"
  end

  def winning_percentage
    self.wins / self.losses
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

end
