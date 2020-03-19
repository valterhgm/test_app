class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :login_fail_count, default: 0
      t.boolean :user_login_lock, default: false

      t.timestamps
    end
  end
end
