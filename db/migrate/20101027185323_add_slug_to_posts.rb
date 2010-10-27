class AddSlugToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :slug, :text
  end

  def self.down
    remove_column :posts, :slug
  end
end
