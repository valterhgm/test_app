require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

	setup do
  		@user = User.new(username: "test", password: "test")
  	end

	test "should get new" do
  		get new_session_url
  		assert_response :success
  	end

  	test "should destroy session and redirect to new session" do
  		delete session_url("session")
  		assert_redirected_to new_session_url(message: "Succesfully Logged Out")
  	end

  	test "should create session" do
  		User.new(username: "test", password: "test").save
  		user = User.last
  		post sessions_url, params: { username: user.username, password: "test"  }
  		assert_redirected_to users_url(message: "User #{user.username} succesfully logged in.")
  	end

  	test "should not detect user" do
  		User.new(username: "test", password: "test").save
  		user = User.last
  		post sessions_url, params: { username: "test_fail", password: "test"  }
  		assert_redirected_to new_session_url(message: "No username test_fail.")
  	end

  	test "should show 2 tries left after one password fail" do
  		User.new(username: "test", password: "test").save
  		user = User.last
  		post sessions_url, params: { username: user.username, password: "test_fail"  }
  		assert_redirected_to new_session_url( message: "Wrong password. You have 2 tries left.")
  	end

  	test "user is locked the fourth time" do
  		User.new(username: "test", password: "test").save
  		user = User.last
  		post sessions_url, params: { username: user.username, password: "test_fail"  }
  		post sessions_url, params: { username: user.username, password: "test_fail"  }
  		post sessions_url, params: { username: user.username, password: "test_fail"  }
  		post sessions_url, params: { username: user.username, password: "test_fail"  }
  		assert_redirected_to new_session_url(  message: "User #{user.username} is locked.")
  	end

end
