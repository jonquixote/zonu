class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.integer :user_a
      t.integer :user_b
      t.timestamps null: false
    end
  end
end