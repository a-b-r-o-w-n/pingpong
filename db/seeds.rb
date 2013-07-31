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


Match.create({
    status:         'C',
    player1:        andy, 
    score1:         11,
    player2:        michael,
    score2:         8
	})

Match.create({
    status:         'C',
    player1:        daniel, 
    score1:         11,
    player2:        andy,
    score2:         6
	})

Match.create({
    status:         'C',
    player1:        kellen,
    score1:         11,
    player2:        michael,
    score2:         8
    })

Match.create({
    status:         'C',
    player1:        kellen,
    score1:         11,
    player2:        andy,
    score2:         6
    })

Match.create({
    status:         'C',
    player1:        kellen,
    score1:         11,
    player2:        daniel,
    score2:         6
    })

Match.create({
    status:         'C',
    player1:        michael,
    score1:         11,
    player2:        daniel,
    score2:         6
    })

Match.create({
    status:         'C',
    player1:        andy,
    score1:         11,
    player2:        kellen,
    score2:         6
    })