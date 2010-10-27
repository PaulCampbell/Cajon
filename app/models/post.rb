# == Schema Information
# Schema version: 20101027185323
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  content    :text
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  published  :boolean
#  slug       :text
#

class Post < ActiveRecord::Base
	belongs_to :user
	has_many :postcomments, :dependent => :destroy  
	
	validates :title, :presence => true, :length => {:maximum => 200 }
	validates :user_id, :presence => true 
	validates :slug, :presence => true, :length => { :maximum => 800 }
	validates :content, :length => { :maximum => 10000 }
	
	attr_accessible :title, :content, :published, :slug
	
	default_scope :order => 'posts.created_at DESC'
	
	cattr_reader :per_page
    @@per_page = 10
	
	def publish
	  this.published = true
	  this.save
	end
	 
end
