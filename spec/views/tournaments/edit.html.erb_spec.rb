require 'spec_helper'

describe "tournaments/edit" do
  before(:each) do
    @tournament = assign(:tournament, stub_model(Tournament,
      :tournament_type => "MyString",
      :num_players => 1
    ))
  end

  it "renders the edit tournament form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tournament_path(@tournament), "post" do
      assert_select "input#tournament_tournament_type[name=?]", "tournament[tournament_type]"
      assert_select "input#tournament_num_players[name=?]", "tournament[num_players]"
    end
  end
end
