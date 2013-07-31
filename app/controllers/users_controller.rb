class UsersController < ApplicationController

 def index
 	# params[:page] ||=1
 	# @users = User.paginate(:page => params[:page], :per_page => 2)
 	@users = User.all.sort_by(&:rank)
 end

end