class UsersController < ApplicationController

	def index
		params[:page] ||=1
		@users = User.order('rank desc').paginate(:page => params[:page], :per_page => 20)
		#@users = User.all.sort_by(&:rank)
	end

end