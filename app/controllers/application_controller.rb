class ApplicationController < ActionController::Base
	before_action :verify_user_authentication
	before_action :current_user
	helper_method :current_user

	private

	def verify_user_authentication
		unless session[:user].present?
			redirect_to new_session_path, notice: "Please Log in"
		end
	end

	def current_user
		@current_user ||= session[:user] ? User.find(session[:user]) : nil
	end

end
