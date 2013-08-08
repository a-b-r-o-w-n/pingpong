json.array!(@tournaments) do |tournament|
  json.extract! tournament, :tournament_type, :num_players
  json.url tournament_url(tournament, format: :json)
end
