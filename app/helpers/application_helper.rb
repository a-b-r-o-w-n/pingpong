module ApplicationHelper

	def pretty_time(time)
		"#{time_ago_in_words(time)} ago"
	end

end
