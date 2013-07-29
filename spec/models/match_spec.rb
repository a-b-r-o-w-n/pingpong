require_relative "../spec_helper"

describe Match do

	it { should belong_to :user_match }
	it { should have_many :players }

	context "when both players are present" do
		let(:match) { FactoryGirl.build(:match) }

		context "when the game is complete" do

			before do 
				match.update_attributes({
					score1: 7,
					score2: 11,
					stats: 'COMPLETE'
					})
			end

			it "should have a winner" do
				assert_equal match.winner, match.player2
			end

		end

	end

end