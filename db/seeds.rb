# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DEFAULT_INSECURE_PASSWORD = 'password'

andy = User.create({
    first_name: "Andy",
    last_name: "Brown",
    profile_name: "andy",
    email: "asbrown002@gmail.com",
    password: DEFAULT_INSECURE_PASSWORD,
    password_confirmation: DEFAULT_INSECURE_PASSWORD
    })  

daniel = User.create({
    first_name: "Daniel",
    last_name: "Crawford",
    profile_name: "daniel",
    email: "daneil@example.com",
    password: DEFAULT_INSECURE_PASSWORD,
    password_confirmation: DEFAULT_INSECURE_PASSWORD
    })

michael = User.create({
    first_name: "Michael",
    last_name: "Gaddy",
    profile_name: "michael",
    email: "michael@example.com",
    password: DEFAULT_INSECURE_PASSWORD,
    password_confirmation: DEFAULT_INSECURE_PASSWORD
    })

kellen = User.create({
    first_name: "Kellen",
    last_name: "Summer",
    profile_name: "kellen",
    email: "kellen@example.com",
    password: DEFAULT_INSECURE_PASSWORD,
    password_confirmation: DEFAULT_INSECURE_PASSWORD
    })

Tournament.create({
    tournament_type: 'SE',
    num_players: 3
    })

Tournament.create({
    tournament_type: 'WS',
    num_players: 3
    })


Match.create({
    status:         'P',
    player1_id:     andy.id, 
    score1:         11,
    player2_id:     michael.id,
    score2:         8,
    tournament_id:  1
	})

Match.create({
    status:         'IP',
    player1_id:     daniel.id, 
    score1:         11,
    player2_id:     andy.id,
    score2:         6,
    tournament_id:  1
	})

Match.create({
    status:         'C',
    player1_id:     kellen.id,
    score1:         11,
    player2_id:     michael.id,
    score2:         8,
    tournament_id:  1
    })

Match.create({
    status:         'C',
    player1_id:     kellen.id,
    score1:         11,
    player2_id:     andy.id,
    score2:         6,
    tournament_id:  2
    })

Match.create({
    status:         'C',
    player1_id:     kellen.id,
    score1:         11,
    player2_id:     daniel.id,
    score2:         6,
    tournament_id:  2
    })

Match.create({
    status:         'C',
    player1_id:     michael.id,
    score1:         11,
    player2_id:     daniel.id,
    score2:         6,
    tournament_id:  2
    })

Match.create({
    status:         'C',
    player1_id:     andy.id,
    score1:         11,
    player2_id:     kellen.id,
    score2:         6,
    tournament_id:  2
    })

Match.all.each do |m|
    TournamentUser.create(user_id: m.player1_id, tournament_id: m.tournament_id)
    TournamentUser.create(user_id: m.player2_id, tournament_id: m.tournament_id)
end

