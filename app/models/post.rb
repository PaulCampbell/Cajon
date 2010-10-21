# == Schema Information
# Schema version: 20101021183927
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
#

class Post < ActiveRecord::Base
	belongs_to :user
	has_many :postcomments, :dependent => :destroy  
	
	validates :title, :presence => true, :length => {:maximum => 3000 }
	validates :user_id, :presence => true 
	validates :title, :length => { :maximum => 200 }
	
	attr_accessible :title, :content, :published
	
	default_scope :order => 'posts.created_at DESC'
	
	cattr_reader :per_page
    @@per_page = 10
	
	def publish
	  this.published = true
	  this.save
	end
	
end
