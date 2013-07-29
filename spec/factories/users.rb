FactoryGirl.define do
	sequence(:email) { |n| "test#{rand(100)*n}@example.com" }

	factory :andy, class: User do
		first_name "Andy"
		last_name "Brown"
		profile_name "andy"
		email "asbrown002@gmail.com"
		password "password"
	end

	factory :daniel, class: User do
		first_name "Daniel"
    last_name "Crawford"
    profile_name "daniel"
    email "daniel@example.com"
    password "password"
	end

	factory :user do
		first_name "Test"
    last_name "User"
    profile_name "user"
    password "password"
    email
	end

end