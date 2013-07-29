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

match1 = Match.create({
    status:         'PENDING',
    player1:        andy, 
    score1:         11,
    player2:        daniel,
    score2:         7
	})

match2 = Match.create({
    status:         'COMPLETE',
    player1:        daniel, 
    score1:         0,
    player2:        andy,
    score2:         0
	})