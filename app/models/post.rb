class Post < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :title 
	validates_presence_of :user 
	validates :title, :length => { :maximum => 250 }
	
	 attr_accessor :title, :content
end
