class Tournament < ActiveRecord::Base
	TYPE_CHOICES = {
		'Round Robin' 				=> 'RR',
		'Single Elimination' 	=> 'SE',
		'Double Elimination' 	=> 'DE',
		'Winner Stays' 				=> 'WS'
	}


	attr_accessible :tournament_type, :num_players, :match_attributes
	

	validates_inclusion_of :tournament_type, in: TYPE_CHOICES.values, allow_nil: true

	has_many :matches
	has_many :tournament_users
	has_many :players, -> { distinct }, through: :tournament_users, source: :user

	accepts_nested_attributes_for :matches

	def long_type
		TYPE_CHOICES.invert[self.tournament_type]
	end

	def initalize
		self.num_players = self.players.count
	end

end
