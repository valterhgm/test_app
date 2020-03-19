require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
  	@user = User.new(username: "test", password: "test")
  end

  test "won't create user without username not password" do
  	user = User.new
  	assert_not user.save
  end

  test "won't create user without username" do
  	user = User.new(password: "test")
  	assert_not user.save
  end

  test "won't create user without password" do
  	user = User.new(username: "test")
  	assert_not user.save
  end

  test "won't create user with username length greater than 10" do
  	user = User.new(username: "qweryuioplk",password: "test")
  	assert_not user.save
  end

  test "won't create user with username length less than 2" do
  	user = User.new(username: "w",password: "test")
  	assert_not user.save
  end

  test "won't create user with password length greater than 6" do
  	user = User.new(username: "quioplk",password: "testqwe")
  	assert_not user.save
  end

  test "won't create user with password length less than 3" do
  	user = User.new(username: "qweryuioplk",password: "te")
  	assert_not user.save
  end

  test "will create user with username length equal to 10" do
  	user = User.new(username: "qwerloiaus",password: "test")
  	assert user.save
  end

  test "will create user with username length equal to 2" do
  	user = User.new(username: "qw",password: "test")
  	assert user.save
  end

  test "will create user with password length equal to 3" do
  	user = User.new(username: "qweryuiop",password: "tes")
  	assert user.save
  end

  test "will create user with password length equal to 6" do
  	user = User.new(username: "qweryu",password: "testqw")
  	assert user.save
  end

  test "user has secure password" do
  	assert_respond_to @user, :password
   	assert_respond_to @user, :authenticate
  end

  test "login_fail_count starts at 0" do 
  	assert_equal 0, @user.login_fail_count
  end

  test "login_fail_count increases with login_fail_increment call" do
  	@user.login_fail_increment
  	assert_equal 1, @user.login_fail_count
  end

  test "username shall be unique" do
  	user = User.new(username: "test", password: "test")
  	user2 = User.new(username: "test", password: "test1")
  	assert user.save
  	assert_not user2.save
  end

  test "login_lock locks the user" do
    @user.login_lock 
    assert @user.user_login_lock
  end

  test "reset_login_fail_count resets login_fail_count attribute after increment" do
    @user.login_fail_increment
    assert_equal 1, @user.login_fail_count
    @user.reset_login_fail_count
    assert_equal 0, @user.login_fail_count
  end

  test "login_tries_left show the right number of tries" do
    @user.login_fail_increment
    assert_equal 2, @user.login_tries_left
    @user.login_fail_increment
    assert_equal 1, @user.login_tries_left
    @user.login_fail_increment
    assert_equal 0, @user.login_tries_left
  end

  test "login_fail_increment locks the user after 3 increments" do
    @user.login_fail_increment
    @user.login_fail_increment
    @user.login_fail_increment
    assert @user.user_login_lock
  end

end
