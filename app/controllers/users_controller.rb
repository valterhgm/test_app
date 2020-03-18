class UsersController < ApplicationController
	def index
		byebug
		@users = User.all
	end
end
