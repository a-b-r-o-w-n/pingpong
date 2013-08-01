class UsersController < ApplicationController

	def index
		params[:page] ||=1
		@users = User.order('rank asc').paginate(:page => params[:page], :per_page => 20)
	end

end