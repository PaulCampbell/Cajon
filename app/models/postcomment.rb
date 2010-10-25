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
	
	#url_regex = \b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/)))
	
	attr_accessible :content, :name, :email, :website
	
	default_scope :order => 'postcomments.created_at ASC'
	validates :content, :presence => true, :length => { :maximum => 500 }
	
	#validates :website, :format => {:with => url_regex}
	
	before_save  :clean_url
	
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
		
		def clean_url
		  unless self.website.nil? or self.website == "" 
			unless self.website =~ /https?:\/\/.*/
				write_attribute :website, "http://" + self.website.to_s
			else
				write_attribute :website, self.website
			end
		  end
		end


end
