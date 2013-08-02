require_relative '../spec_helper'

describe User do
  
	it { should have_many :matches1 }
	it { should have_many :matches2 }

	# it "should call #update_stats when created" do
	# 	user = FactoryGirl.create(:user)
	# NOTE: forgot receive syntax
	# 	expect(user).to receive(:update_stats)
	# end

	let(:user) { FactoryGirl.build(:user) }

	context "with invalid paramters" do
		let(:invalid_profile_names) { ["invalid name", "not/valid", "in.valid", "in@valid"] }

		# it "should deny profile_name" do
		# 	invalid_profile_names.each do |n|
		# 		binding.pry
		# 		@user = FactoryGirl.create(:user, profile_name: n)
		# 		expect(user).to be_invalid
		# 	end
		# end

	end

end