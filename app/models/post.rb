class Post < ActiveRecord::Base
	belongs_to :user
	
	validates :title, :length => { :maximum => 140 }
end
