# == Schema Information
# Schema version: 20101021184733
#
# Table name: postcomments
#
#  id         :integer         not null, primary key
#  content    :text
#  post_id    :integer
#  name       :string(255)
#  email      :string(255)
#  website    :string(255)
#  approved   :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Postcomment < ActiveRecord::Base
	belongs_to :post
	
	
	attr_accessible :content, :name, :email, :website
	
	default_scope :order => 'postcomments.created_at ASC'
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :content, :presence => true, :length => { :maximum => 500 }
	validates :email,	:format       => { :with => email_regex }
	
	def friendly_name
		if name == "" 
			"anonymous"
		else
			 name
		end
	end


end
