# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tournament do
    tournament_type "MyString"
    num_players 1
  end
end
