require_relative "../spec_helper"

describe Match do

	it { should belong_to :player1 }
	it { should belong_to :player2 }

	context "when both players are present" do
		let(:match) { FactoryGirl.build(:match) }

		context "when the game is not complete" do

			it "should not have a winner" do
				expect(match.winner).to be_nil
			end

		end

		context "when the game is complete" do

			before do 
				match.update_attributes({
					score1: 7,
					score2: 11,
					stats: 'C'
					})
			end

			it "should have a winner" do
				assert_equal match.winner, match.player2
			end

		end

    context "it only has certain statuses" do
      let(:valid_statuses)  { ['C', 'P', 'X'] }
      let(:invalid_statuses){ ('A'..'Z').map {|l| l}.delete_if{|l| ['C','P','X'].include? l} }

      it "[valid statuses]" do
        valid_statuses.each do |s|
          match.status = s
          expect(match).to be_valid
        end
      end

     it "[invalid status]" do
       invalid_statuses.each do |s|
         match.status = s
         expect(match.save).to_not be_true
       end
     end

   end

 end

end
