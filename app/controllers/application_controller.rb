class ApplicationController < ActionController::Base
	def current_user
		if session[:user].present?
			user = User.find(session[:user])
		end
		user
	end
end
