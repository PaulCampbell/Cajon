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
	
	before_save :format_comment, :clean_url
	
	def after_initialize 
      return unless new_record?
      self.approved = true
    end
	
	def friendly_name
		if name == "" or name.nil?
			"Anonymous"
		else
			 name
		end
	end
	
	
	private
		def format_comment
		   self.content.gsub(/\n/, "<br/>")
		end
		
		def clean_url
			unless self.website =~ /https?:\/\/.*/
				write_attribute :website, "http://" + self.website.to_s
			else
				write_attribute :website, self.website
			end
		end


end
