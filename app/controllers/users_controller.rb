class UsersController < ApplicationController
	before_action :verify_user_authentication

	def index
		@users = User.all
	end

	private

	def verify_user_authentication
		unless session[:user].present?
			redirect_to new_session_path, notice: "Please Log in"
		end
	end
end
