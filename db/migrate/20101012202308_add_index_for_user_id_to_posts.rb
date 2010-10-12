class AddIndexForUserIdToPosts < ActiveRecord::Migration
  def self.up
    add_index :posts, :user_id
  end

  def self.down
  end
end
