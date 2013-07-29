json.array!(@matches) do |match|
  json.extract! match, :player1_id, :player2_id, :score1, :score2
  json.url match_url(match, format: :json)
end
