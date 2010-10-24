# == Schema Information
# Schema version: 20101021184733
#
# Table name: postcomments
#
#  id         :integer         not null, primary key
#  content    :text
#  post_id    :integer
#  name       :string(255)
#  website    :string(255)
#  approved   :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Postcomment < ActiveRecord::Base
	belongs_to :post
	
	
	attr_accessible :content, :name, :email, :website
	
	default_scope :order => 'postcomments.created_at ASC'
	validates :content, :presence => true, :length => { :maximum => 500 }
	
	def friendly_name
		if name == "" 
			"Anonymous"
		else
			 name
		end
	end


end
