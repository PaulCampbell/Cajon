class User < ActiveRecord::Base
	has_many :posts
    validates_presence_of :email, :name
	
	 attr_accessor :name, :email
end
