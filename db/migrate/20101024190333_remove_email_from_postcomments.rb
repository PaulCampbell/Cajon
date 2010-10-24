class RemoveEmailFromPostcomments < ActiveRecord::Migration
  def self.up
	 remove_column :postcomments, :email 
  end

  def self.down
	add_column :postcomments, :email , :string
  end
end
