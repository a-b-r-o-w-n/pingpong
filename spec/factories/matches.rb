FactoryGirl.define do


	factory :match do
		association :player1, factory: :user
		association :player2, factory: :user

		factory :pending_match do
			status 'P'
		end

		factory :complete_match do 
			status 'C'
			score1 7
			score2 11
		end
	end

end