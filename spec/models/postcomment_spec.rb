require 'spec_helper'

describe Postcomment do
 before(:each) do
    @attr = { :website => "http://www.decoratedworld.com",
  :name => "Paul",
  :content => "My comment content",
  :approved => true,
  :email => "paulgcampbell@gmail.com" }
  end

  it "should create a new instance given valid attributes" do
    Postcomment.create!(@attr)
  end

  it "should require content" do
    no_content_comment = Postcomment.new(@attr.merge(:content => ""))
    no_content_comment.should_not be_valid
  end
  
  it "should not allow content to be too long" do
    too_long_content_comment = Postcomment.new(@attr.merge(:content => "a" * 501))
    too_long_content_comment.should_not be_valid
  end
  
  
  it "should return friendly value if name is empty" do
	no_name_comment = Postcomment.new(@attr.merge(:name => ""))
	no_name_comment.friendly_name.should == "anonymous"
  end
  
  it "should return name if name is not empty" do
	no_name_comment = Postcomment.new(@attr)
	no_name_comment.friendly_name.should == "Paul"
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_postcomment = Postcomment.new(@attr.merge(:email => address))
      valid_email_postcomment.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_postcomment = Postcomment.new(@attr.merge(:email => address))
      invalid_email_postcomment.should_not be_valid
    end
  end
  
  
  describe "post associations" do
     
    before(:each) do
	  @post = Factory(:post)
      @postcomment = @post.postcomments.create(@attr)
    end
    
    it "should have a post attribute" do
      @post.should respond_to(:user)
    end
    
    it "should have the correct post associated" do
      @postcomment.post_id.should == @post.id
      @postcomment.post.should == @post
    end
    
  end

  
end
