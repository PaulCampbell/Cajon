# == Schema Information
# Schema version: 20101009095917
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  content    :text
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :title 
	validates_presence_of :user 
	validates :title, :length => { :maximum => 250 }
	
	 attr_accessor :title, :content
end
