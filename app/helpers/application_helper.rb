module ApplicationHelper

	def pretty_time(time)
		"#{time_ago_in_words(time)} ago"
	end

	def edit?
		current_user.try(:admin?)
	end
end
