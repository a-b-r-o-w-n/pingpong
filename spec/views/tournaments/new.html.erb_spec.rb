require 'spec_helper'

describe "tournaments/new" do
  before(:each) do
    assign(:tournament, stub_model(Tournament,
      :tournament_type => "MyString",
      :num_players => 1
    ).as_new_record)
  end

  it "renders new tournament form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tournaments_path, "post" do
      assert_select "input#tournament_tournament_type[name=?]", "tournament[tournament_type]"
      assert_select "input#tournament_num_players[name=?]", "tournament[num_players]"
    end
  end
end
