class ChangeLoginFailCountDefaultValueInUser < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :login_fail_count, :integer, default: 0
  end
end
