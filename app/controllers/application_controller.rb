class ApplicationController < ActionController::Base
	before_action :current_user
	helper_method :current_user

	private

	def current_user
		@current_user ||= session[:user] ? User.find(session[:user]) : nil
	end

end
