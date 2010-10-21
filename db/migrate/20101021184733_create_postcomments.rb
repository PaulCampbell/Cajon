class CreatePostcomments < ActiveRecord::Migration
  def self.up
    create_table :postcomments do |t|
      t.text :content
      t.integer :post_id
      t.string :name
      t.string :email
      t.string :website
      t.boolean :approved

      t.timestamps
    end
	add_index :postcomments, :post_id
  end

  def self.down
    drop_table :postcomments
  end
end
