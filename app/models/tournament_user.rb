class TournamentUser < ActiveRecord::Base

	attr_accessible :user_id, :tournament_id

	belongs_to :user
	belongs_to :tournament

end
