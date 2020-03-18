class AddUserLoginLockToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_login_lock, :boolean, default: false
  end
end
