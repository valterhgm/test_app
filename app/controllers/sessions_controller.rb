class SessionsController < ApplicationController
	skip_before_action :verify_user_authentication, only: [:new,:create]
	
	def new;end

	def create
		user = User.find_by(username: params[:username])
		if user.present?
			if user.authenticate(params[:password]) && !user.user_login_lock
				user.reset_login_fail_count
				session[:user] ||= user.id if user.present?
				redirect_to users_path, notice: 'Succesfully Log in'
			else
				login_fail user
			end
		else
			redirect_to new_session_path, notice: "idjid"
		end
	end

	def destroy
		session.delete :user
		redirect_to controller: :sessions, action: :new, message: "Succesfully Logged Out"
	end

	private

	def login_fail user
		if user.user_login_lock
			redirect_to controller: :sessions, action: :new, message: "User #{user.username} is locked."
		else
			user.login_fail_increment
			redirect_to new_session_path, notice: "Wrong password. You have #{user.login_tries_left} tries left."
		end
	end

end
