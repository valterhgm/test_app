class UsersController < ApplicationController
	before_action :user_auth

	def index
		@users = User.all
	end

	private

	def user_auth
		unless session[:user].present?
			redirect_to new_session_path, notice: "Please Log in"
		end
	end
end
