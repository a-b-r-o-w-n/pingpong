class UsersController < ApplicationController

 def index
 	@users = User.all.sort_by(&:rank)
 end

end