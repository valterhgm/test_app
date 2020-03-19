class User < ApplicationRecord
	validates :username, uniqueness: true
	validates :username, length: { in: 2..10 }
	validates :password, length: { in: 3..6 }

	def login_fail_increment
		increment!(:login_fail_count, 1)
		if login_fail_count > 2
			login_lock
		end
	end

	def login_lock
		update_attribute :user_login_lock, true
	end

	def reset_login_fail_count
		update_attribute :login_fail_count, 0
	end

	def login_tries_left
		3 - login_fail_count
	end

	def authenticate given_password
		given_password == password_digest
	end


end
